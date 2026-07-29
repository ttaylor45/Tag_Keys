# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_29_032219) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.bigint "author_id"
    t.string "author_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.string "namespace"
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id", "game_id"], name: "index_cart_items_on_cart_id_and_game_id", unique: true
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["game_id"], name: "index_cart_items_on_game_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "game_genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "genre_id"], name: "index_game_genres_on_game_id_and_genre_id", unique: true
    t.index ["game_id"], name: "index_game_genres_on_game_id"
    t.index ["genre_id"], name: "index_game_genres_on_genre_id"
  end

  create_table "game_keys", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.bigint "order_item_id", null: false
    t.datetime "sold_at"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_game_keys_on_code", unique: true
    t.index ["game_id"], name: "index_game_keys_on_game_id"
    t.index ["order_item_id"], name: "index_game_keys_on_order_item_id"
    t.index ["status"], name: "index_game_keys_on_status"
  end

  create_table "games", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "developer", null: false
    t.boolean "featured", default: false, null: false
    t.string "header_image_url"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "publisher", null: false
    t.date "release_date"
    t.decimal "sale_price", precision: 10, scale: 2
    t.integer "steam_app_id"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_games_on_active"
    t.index ["category_id"], name: "index_games_on_category_id"
    t.index ["featured"], name: "index_games_on_featured"
    t.index ["steam_app_id"], name: "index_games_on_steam_app_id", unique: true
    t.index ["title"], name: "index_games_on_title"
  end

  create_table "genres", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.decimal "line_total", precision: 10, scale: 2, null: false
    t.bigint "order_id", null: false
    t.string "product_title", null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_order_items_on_game_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "address_line_1", null: false
    t.string "address_line_2", null: false
    t.string "city", null: false
    t.datetime "created_at", null: false
    t.decimal "grand_total", precision: 10, scale: 2, null: false
    t.decimal "gst_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "gst_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.decimal "hst_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "hst_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.string "order_number", null: false
    t.datetime "paid_at"
    t.string "postal_code", null: false
    t.bigint "province_id", null: false
    t.string "province_name", null: false
    t.decimal "pst_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "pst_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.decimal "subtotal", precision: 10, scale: 2, null: false
    t.decimal "tax_total", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["order_number"], name: "index_orders_on_order_number", unique: true
    t.index ["province_id"], name: "index_orders_on_province_id"
    t.index ["status"], name: "index_orders_on_status"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "page_contents", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.string "page_key", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["page_key"], name: "index_page_contents_on_page_key", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.bigint "order_id", null: false
    t.datetime "paid_at"
    t.string "provider", null: false
    t.string "provider_customer_id"
    t.string "provider_payment_id"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id", unique: true
    t.index ["provider_payment_id"], name: "index_payments_on_provider_payment_id", unique: true
  end

  create_table "provinces", force: :cascade do |t|
    t.string "abbreviation", null: false
    t.datetime "created_at", null: false
    t.decimal "gst_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.decimal "hst_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.string "name", null: false
    t.decimal "pst_rate", precision: 5, scale: 4, default: "0.0", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "index_provinces_on_abbreviation", unique: true
    t.index ["name"], name: "index_provinces_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "postal_code"
    t.bigint "province_id"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["province_id"], name: "index_users_on_province_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "games"
  add_foreign_key "carts", "users"
  add_foreign_key "game_genres", "games"
  add_foreign_key "game_genres", "genres"
  add_foreign_key "game_keys", "games"
  add_foreign_key "game_keys", "order_items"
  add_foreign_key "games", "categories"
  add_foreign_key "order_items", "games"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "provinces"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "users", "provinces"
end
