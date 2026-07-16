class CreateGameKeys < ActiveRecord::Migration[8.1]
  def change
    create_table :game_keys do |t|
      t.references :game, null: false, foreign_key: true
      t.references :order_item, null: false, foreign_key: true
      t.string :code, null: false
      t.integer :status, default: 0, null: false
      t.datetime :sold_at

      t.timestamps
    end

    add_index :game_keys, :code, unique: true
    add_index :game_keys, :staus
  end
end
