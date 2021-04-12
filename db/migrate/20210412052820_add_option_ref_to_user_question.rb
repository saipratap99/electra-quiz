class AddOptionRefToUserQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_questions, :option, null: true, foreign_key: true
    add_reference :user_questions, :question, null: false, foreign_key: true
  end
end
