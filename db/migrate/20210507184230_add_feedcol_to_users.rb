class AddFeedcolToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :feedback2, :string
    rename_column :users, :feedback, :feedback1
  end
end
