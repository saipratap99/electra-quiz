class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :ans
      t.string :ques_type
      t.integer :level
      t.integer :user_id

      t.timestamps
    end
  end
end
