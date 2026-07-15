class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.integer :steam_app_id, null: false

      t.references :category,
                   null: false,
                   foreign_key: true

      t.string :title, null: false
      t.text :description, null: false

      t.decimal :price,
                precision: 10,
                scale: 2,
                null: false

      t.decimal :sale_price,
                precision: 10,
                scale: 2

      t.string :developer, null: false
      t.string :publisher, null: false
      t.date :release_date

      t.boolean :active, default: true, null: false
      t.boolean :featured, default: false, null: false

      t.timestamps
    end

    add_index :games, :steam_app_id, unique: true
    add_index :games, :title
    add_index :games, :active
    add_index :games, :featured
  end
end
