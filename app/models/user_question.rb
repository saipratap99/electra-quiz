class UserQuestion < ApplicationRecord
  belongs_to :question

  def self.createQuestions(current_user, quiz_type, level)
    puts "######### #{quiz_type} #{level} ###########"
    if current_user.user_questions.where("ques_type = ? AND level = ?", quiz_type, level).count == 0
      Question.where("ques_type = ? AND level = ?", quiz_type, level).each do |ques|
        current_user.user_questions.create({ question_id: ques.id, ques_type: ques.ques_type, level: ques.level })
      end
    end
  end

  def self.createQuestionsAgain(current_user)
    current_user.user_questions.all.each do |ques|
      ques.is_attempted = false
      ques.save!
    end
  end
end
