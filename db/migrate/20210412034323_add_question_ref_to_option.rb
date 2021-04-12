class AddQuestionRefToOption < ActiveRecord::Migration[6.0]
  def change
    add_reference :options, :question, null: false, foreign_key: true
  end
end
