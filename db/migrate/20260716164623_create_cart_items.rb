class CreateCartItems < ActiveRecord::Migration[8.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true

      t.references :game, null: false, foreign_key: true

      t.integer :quantity, default: 1, null: false

      t.timestamps
    end

    add_index :cart_items, [ :cart_id, :game_id ], unique: true
  end
end
