class UserQuestion < ApplicationRecord
  belongs_to :question

  def self.createQuestions(current_user)
    if current_user.user_questions.all.count == 0
      Question.all.each do |ques|
        current_user.user_questions.create({ question_id: ques.id })
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
