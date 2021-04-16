class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: ["new", "login"]

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
        redirect_to(questions_path, notice: "Quiz has been started!")
        @user.user_loged_in
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
    @current_user.user_loged_out
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
end
