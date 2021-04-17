class UserQuestionsController < ApplicationController
  def index
    # @tech_questions = UserQuestion.getTechQuestions(@current_user)
    # @non_tech_questions = UserQuestion.getNonTechQuestions(@current_user)
    ## @questions = @current_user.user_questions.order(id: :asc)
    UserQuestion.createQuestions

    @question = UserQuestion.where(is_attempted: false).first
    questions_count = UserQuestion.all.count
    ques_remaining_count = UserQuestion.where(is_attempted: false).count - 1

    @question_number = "Question: #{questions_count - ques_remaining_count}/#{questions_count}"

    redirect_to :summary if @question == nil
  end

  def save_score
    id = params[:id]
    score = params[:score]
    @ques = UserQuestion.find(id)
    @ques.scored = score.to_i
    @ques.save
    respond_to do |format|
      format.html { redirect_to("/user_questions/index", notice: "Response submited!") }
      format.js
    end
  end

  def store_response
    option_id = params[:option].to_i
    commit = params[:commit]
    questions_count = UserQuestion.all.count
    unattempted_questions = UserQuestion.where(is_attempted: false).order(:id)
    ques_remaining_count = unattempted_questions.count - 1

    @ques = unattempted_questions.first
    @question_number = "Question: #{questions_count + 1 - ques_remaining_count}/#{questions_count}"

    if option_id == 0
      @ques.option_id = nil
    else
      @ques.option_id = option_id
    end
    @response = commit == "submit" ? "Response submited!" : "Question skipped!"
    @ques.is_attempted = true
    @ques.save

    redirect_to :summary if ques_remaining_count == 0

    respond_to do |format|
      format.js
    end
  end

  def summary
    @questions = UserQuestion.all
  end

  def submit
    render js: "console.log('submited');"
  end
end
