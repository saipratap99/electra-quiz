class UserQuestion < ApplicationRecord
  belongs_to :question

  def self.createQuestions
    if UserQuestion.all.count == 0
      Question.all.each do |ques|
        UserQuestion.create({ question_id: ques.id })
      end
    end
  end
end
