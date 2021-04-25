class UserQuestion < ApplicationRecord
  belongs_to :question

  def self.createQuestions(current_user)
    if current_user.user_questions.all.count == 0
      Question.all.each do |ques|
        current_user.user_questions.create({ question_id: ques.id })
      end
    else
      UserQuestion.all.each do |x|
        x.is_attempted = false
        x.save!
      end
    end
  end
end
