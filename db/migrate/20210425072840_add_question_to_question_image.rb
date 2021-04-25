class AddQuestionToQuestionImage < ActiveRecord::Migration[6.0]
  def change
    add_reference :question_images, :questions, null: false, foreign_key: true
  end
end
