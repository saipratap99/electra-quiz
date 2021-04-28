class AddColsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :tech_1_started_at, :datetime
    add_column :users, :tech_2_started_at, :datetime
    add_column :users, :non_tech_1_started_at, :datetime
    add_column :users, :non_tech_2_started_at, :datetime
    add_column :users, :tech_1_score, :integer, default: 0
    add_column :users, :tech_2_score, :integer, default: 0
    add_column :users, :non_tech_1_score, :integer, default: 0
    add_column :users, :non_tech_2_score, :integer, default: 0
    add_column :user_questions, :scored, :integer, default: 0
    add_column :quizzes, :total_questions, :integer, default: 0
  end
end
