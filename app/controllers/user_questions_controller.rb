class UserQuestionsController < ApplicationController
  def index
    if ensure_user_logged_in_given_slot
      UserQuestion.createQuestions(@current_user, @quiz_type, @level)

      @question = @current_user.user_questions.where("is_attempted = ? AND ques_type = ? AND level = ?", false, @quiz_type, @level).order(:id).first
      if @question
        @contains_image = false
        @image = nil
        if @question.question.contains_image
          @contains_image = true
          @image = @question.question.question_images.first.image_url
        end
      end
      questions_count = @current_user.user_questions.where("ques_type = ? AND level = ?", @quiz_type, @level).count
      ques_remaining_count = @current_user.user_questions.where("is_attempted = ? AND ques_type = ? AND level = ?", false, @quiz_type, @level).count - 1

      @question_number = "Question: #{questions_count - ques_remaining_count}/#{questions_count}"

      redirect_to :summary if @question == nil
    else
      redirect_to :timings
    end
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
    ensure_user_logged_in_given_slot
    option_id = params[:option].to_i
    commit = params[:commit]
    questions_count = @current_user.user_questions.where("ques_type = ? AND level = ?", @quiz_type, @level).count

    unattempted_questions = @current_user.user_questions.where("is_attempted = ? AND ques_type = ? AND level = ?", false, @quiz_type, @level).order(:id)
    ques_remaining_count = unattempted_questions.count - 1

    @ques = unattempted_questions.first
    if option_id == 0
      @ques.option_id = nil
    else
      @ques.option_id = option_id
    end
    @response = commit == "submit" ? "Response submited!" : "Question skipped!"
    @ques.is_attempted = true
    @ques.save

    redirect_to :summary if ques_remaining_count == 0

    if ques_remaining_count != 0
      # new question
      @question = @current_user.user_questions.where("is_attempted = ? AND ques_type = ? AND level = ?", false, @quiz_type, @level).order(:id).first
      @contains_image = false
      @image = nil
      if @question.question.contains_image
        @contains_image = true
        @image = @question.question.question_images.first.image_url
      end
      @question_number = "Question: #{questions_count + 1 - ques_remaining_count}/#{questions_count}"

      respond_to do |format|
        format.js
      end
    else
      if (@quiz_type == "tech")
        set_attr = "@current_user.#{@quiz_type}_#{@level}_started_at = nil"
      else
        set_attr = "@current_user.non_tech_#{@level}_started_at = nil"
      end
      eval(set_attr)
      @current_user.save!
    end
  end

  def summary
    @questions = UserQuestion.all
  end

  def submit
    render js: "console.log('submited');"
  end

  def get_questions
    UserQuestion.createQuestionsAgain(@current_user)
    redirect_to root_path
  end
end
