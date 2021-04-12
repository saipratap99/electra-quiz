class UserQuestionsController < ApplicationController
  def index
    # @tech_questions = UserQuestion.getTechQuestions(@current_user)
    # @non_tech_questions = UserQuestion.getNonTechQuestions(@current_user)
    ## @questions = @current_user.user_questions.order(id: :asc)
    UserQuestion.createQuestions
    @question = UserQuestion.where(is_attempted: false).first
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
    ques = UserQuestion.where(is_attempted: false).first
    if option_id == 0
      ques.option_id = nil
    else
      ques.option_id = option_id
    end

    ques.is_attempted = true
    ques.save

    respond_to do |format|
      format.js
    end
  end
end
