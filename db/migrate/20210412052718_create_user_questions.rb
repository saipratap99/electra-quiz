class CreateUserQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_questions do |t|
      t.boolean :is_attempted, default: false

      t.timestamps
    end
  end
end
