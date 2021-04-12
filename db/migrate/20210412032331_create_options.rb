class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.string :option
      t.boolean :is_image, default: false

      t.timestamps
    end
  end
end
