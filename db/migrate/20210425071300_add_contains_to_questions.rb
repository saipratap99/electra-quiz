class AddContainsToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :contains_image, :boolean, default: false
    add_column :options, :contains_image, :boolean, default: false
    add_column :options, :image_url, :string
  end
end
