class AddFeedbackToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :feedback, :string
  end
end
