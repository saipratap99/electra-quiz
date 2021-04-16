class User < ApplicationRecord
  has_many :user_questions
  validates :name, presence: true, length: { in: 3..50 }
  validates :regno, presence: true, uniqueness: true

  def user_logged_in
    self.current_sign_in_at = Time.now
    self.save
  end

  def user_logged_out
    self.last_sign_in_at = Time.now
    self.save
  end

  def generateTechQues
    questions = Question.all.where(ques_type: "tech").ids
    questions.each do |ques|
      UserQuestion.create(question_id: ques, user_id: id)
    end
  end

  def generateNonTechQues
    questions = Question.all.where(ques_type: "non-tech").ids
    questions.each do |ques|
      UserQuestion.create(question_id: ques, user_id: id)
    end
  end

  def self.user_performances
    all.each do |user|
      tech, non_tech, interaction = 0, 0, 0
      user.user_questions.each do |ques|
        tech += ques.scored if ques.question.ques_type == "tech"
        non_tech += ques.scored if ques.question.ques_type == "non-tech"
        interaction += ques.scored if ques.question.ques_type == "interaction"
      end
      user.tech_marks = tech
      user.non_tech_marks = non_tech
      user.interaction_marks = interaction
      user.save
    end
  end
end
