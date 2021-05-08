class AddColeeToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :feedback1, :feedback
  end
end
