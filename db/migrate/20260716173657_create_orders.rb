class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.string :order_number, null: false
      t.integer :status, default: 0, null: false
      t.decimal :subtotal, precision: 10, scale: 2, null: false
      t.decimal :gst_rate, precision: 5, scale: 4, default: 0, null: false
      t.decimal :pst_rate, precision: 5, scale: 4, default: 0, null: false
      t.decimal :hst_rate, precision: 5, scale: 4, default: 0, null: false
      t.decimal :gst_amount, precision: 10, scale: 2, default: 0, null: false
      t.decimal :pst_amount, precision: 10, scale: 2, default: 0, null: false
      t.decimal :hst_amount, precision: 10, scale: 2, default: 0, null: false
      t.decimal :tax_total, precision: 10, scale: 2, default: 0, null: false
      t.decimal :grand_total, precision: 10, scale: 2, null: false
      t.string :address_line_1, null: false
      t.string :address_line_2, null: false
      t.string :city, null: false
      t.string :postal_code, null: false
      t.string :province_name, null: false

      t.datetime :paid_at

      t.timestamps
    end

    add_index :orders, :order_number, unique: true
    add_index :orders, :status
  end
end
