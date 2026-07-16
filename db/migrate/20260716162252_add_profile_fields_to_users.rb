class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :city, :string
    add_column :users, :postal_code, :string

    add_reference :users,
                  :province,
                  null: true,
                  foreign_key: true

    add_column :users,
               :role,
               :integer,
               default: 0,
               null: false

    add_index :users, :username, unique: true
  end
end
