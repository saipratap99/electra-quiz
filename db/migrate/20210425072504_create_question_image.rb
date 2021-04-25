class CreateQuestionImage < ActiveRecord::Migration[6.0]
  def change
    create_table :question_images do |t|
      t.string :image_url
    end
  end
end
