class CreateQuiz < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string :name
      t.integer :level
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :closing_time

      t.timestamps
    end
  end
end
