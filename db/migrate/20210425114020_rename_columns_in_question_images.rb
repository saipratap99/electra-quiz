class RenameColumnsInQuestionImages < ActiveRecord::Migration[6.0]
  def change
    rename_column :question_images, :questions_id, :question_id
  end
end
