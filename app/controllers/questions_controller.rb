class QuestionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
  end

  def new
  end

  def create
    question = params[:question]
    contains_image = params[:contains_image].to_i
    image_url = params[:image_url]
    count = params[:button].to_i
    level = params[:level].to_i
    ques_type = params[:ques_type]
    if contains_image == 0
      ques = Question.create({ question: question, ques_type: ques_type, level: level })
    else
      ques = Question.create({ question: question, ques_type: ques_type, level: level, contains_image: true })
      ques.question_images.create({ image_url: image_url })
    end
    for i in 1..count
      param_image = "opt#{i}_image".to_sym
      param = "opt#{i}".to_sym
      if (params[param_image].to_i == 0)
        ques.options.create({ option: params[param] })
      else
        ques.options.create({ contains_image: true, image_url: params[param_image] })
      end
    end
    redirect_to :new_question
  end
end
