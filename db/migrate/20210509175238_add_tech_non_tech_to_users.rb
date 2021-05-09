class AddTechNonTechToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :tech_score, :integer, default: 0
    add_column :users, :non_tech_score, :integer, default: 0
  end
end
