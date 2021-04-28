class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: ["new", "login"]
  before_action :ensure_user_logged_in_given_slot, only: ["quiz_details"]

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

  def index
  end

  def login
    email = params[:email]
    password = params[:password]
    @user = User.where(email: email).first
    if @user
      if @user.password == password
        @current_user = @user
        session[:current_user_id] = @user.id

        if ensure_user_logged_in_given_slot
          redirect_to(quiz_details_path)
        else
          redirect_to :timings
        end
        @user.user_logged_in
      else
        flash[:error] = "Invalid password!"
        redirect_to root_path
      end
    else
      redirect_to(root_path, alert: "Invalid Email!")
    end
  end

  def new
  end

  def destroy
    @current_user.user_logged_out
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to(root_path, notice: "Logged out successfully!")
  end

  def question
  end

  def add
    question = params[:question]
    ans = params[:ans]
    ques_type = params[:ques_type]
    Question.create(question: question, ans: ans, ques_type: ques_type)
    redirect_to(question_path, notice: "Question added!")
  end

  def quiz_details
    @user = User.find(@current_user.id)
  end

  def timings
  end
end
