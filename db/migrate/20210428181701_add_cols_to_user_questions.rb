class AddColsToUserQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :user_questions, :ques_type, :string
    add_column :user_questions, :level, :integer
  end
end
