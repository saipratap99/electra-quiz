class UserQuestionsController < ApplicationController
  def index
    # @tech_questions = UserQuestion.getTechQuestions(@current_user)
    # @non_tech_questions = UserQuestion.getNonTechQuestions(@current_user)
    ## @questions = @current_user.user_questions.order(id: :asc)
    UserQuestion.createQuestions
    @question = UserQuestion.where(is_attempted: false).first
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
    unattempted_questions = UserQuestion.where(is_attempted: false).order(:id)
    ques_count = unattempted_questions.count - 1

    ques = unattempted_questions.first

    if option_id == 0
      ques.option_id = nil
    else
      ques.option_id = option_id
    end

    ques.is_attempted = true
    ques.save

    redirect_to :summary if unattempted_questions.count == 0

    respond_to do |format|
      format.js
    end
  end

  def summary
    @questions = UserQuestion.all
  end
end
