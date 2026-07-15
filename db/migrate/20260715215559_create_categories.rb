class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
