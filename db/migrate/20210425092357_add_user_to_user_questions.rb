class AddUserToUserQuestions < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_questions, :user, null: false, foreign_key: true
  end
end
