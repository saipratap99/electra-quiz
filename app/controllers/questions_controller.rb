class QuestionsController < ApplicationController
  # skip_before_action :ensure_user_logged_in
  before_action :ensure_user_is_admin

  def ensure_user_is_admin
    ensure_user_logged_in
    if current_user.role != "admin"
      redirect_to(root_path, alert: "You're not allowed to access!")
    end
  end

  def index
    level = params[:level] == nil ? 1 : params[:level].to_i
    type = params[:type] == nil ? "tech" : params[:type]
    @questions = Question.where("ques_type = ? AND level = ?", type, level)
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
    ans = params[:option]

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
        opt = ques.options.create({ option: params[param] })
      else
        opt = ques.options.create({ contains_image: true, image_url: params[param] })
      end
      if (ans == "opt#{i}")
        ques.ans = opt.id
        ques.save!
      end
    end
    redirect_to :new_question
  end
end
