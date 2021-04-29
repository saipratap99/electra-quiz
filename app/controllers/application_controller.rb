class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  def ensure_user_logged_in
    unless current_user
      redirect_to(root_path, alert: "Please login before continuing")
    end
  end

  def ensure_user_logged_in_given_slot
    user = User.find(@current_user.id)
    if user.tech_1_started_at || user.tech_2_started_at || user.non_tech_1_started_at || user.non_tech_2_started_at
      quizzes_curr = Quiz.where("start_time <= ? AND end_time >= ?", DateTime.now, DateTime.now)
    else
      quizzes_curr = Quiz.where("start_time <= ? AND  closing_time >= ?", DateTime.now, DateTime.now)
    end

    if user.appears_for == "tech"
      quiz = quizzes_curr.where(name: "Technical").first if !quizzes_curr.empty?
    elsif user.appears_for == "non-tech"
      quiz = quizzes_curr.where(name: "Non Technical").first if !quizzes_curr.empty?
    else
      quiz = quizzes_curr.first if !quizzes_curr.empty?
    end

    if quiz
      @quiz_type = quiz.name == "Technical" ? "tech" : "non-tech"
      @level = quiz.level
      if @quiz_type == "tech"
        if @level == 1
          user.tech_1_started_at = DateTime.now
        else
          user.tech_2_started_at = DateTime.now
        end
      else
        if @level == 1
          user.non_tech_1_started_at = DateTime.now
        else
          user.non_tech_2_started_at = DateTime.now
        end
      end
      user.save!
      return true
    else
      # redirect
      return false
    end
  end

  def current_user
    return @current_user if @current_user

    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
