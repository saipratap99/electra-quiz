class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :year
      t.string :branch
      t.string :regno
      t.string :phone
      t.string :email, null: false
      t.string :password
      t.string :appears_for
      t.string :role, default: "participant"
      t.datetime :password_sent_at
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at

      t.timestamps
    end
  end
end
