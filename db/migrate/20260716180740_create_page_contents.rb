class CreatePageContents < ActiveRecord::Migration[8.1]
  def change
    create_table :page_contents do |t|
      t.string :page_key, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :page_contents, :page_key, unique: true
  end
end
