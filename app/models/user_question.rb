class UserQuestion < ApplicationRecord
  belongs_to :question

  def self.createQuestions
    if UserQuestion.all.count == 0
      Question.all.each do |ques|
        UserQuestion.create({ question_id: ques.id })
      end
    else
      UserQuestion.all.each do |x|
        x.is_attempted = false
        x.save!
      end
    end
  end
end
