class UsersController < ApplicationController
  # skip_before_action :ensure_user_logged_in, only: ["new", "create", "performance"]

  def index
  end

  def create
    regno = params[:regno]
    name = params[:name]
    exists = User.where("regno = ?", regno).exists?
    user = exists ?
      User.where("regno = ?", regno).first :
      User.new(name: name, regno: regno.to_i)
    if (regno.length == 9) && (name.length > 3)
      if user.save
        ques = Question.where(ques_type: "interaction").first
        if user.user_questions.count == 0
          user.generateTechQues
          user.generateNonTechQues
          user.user_questions.create(question_id: ques.id)
          # elsif user.user_questions.count == 6
          #   user.generateNonTechQues
          # elsif user.user_questions.count == 4
          #   user.generateTechQues
        end
        @current_user = user
        session[:current_user_id] = user.id
        redirect_to(questions_path, notice: "You can ask question now!")
      else
        flash[:error] = user.errors.full_messages
        redirect_to root_path
      end
    else
      redirect_to(root_path, alert: "Invalid Name or Registration number")
    end
  end

  def new
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to(root_path, notice: "Enter details of applicant to start recruitment!")
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

  def performance
    User.user_performances
    @users = User.all
  end
end
