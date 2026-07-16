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

ActiveRecord::Schema[8.1].define(version: 2026_07_16_164623) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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

  create_table "games", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "developer", null: false
    t.boolean "featured", default: false, null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "publisher", null: false
    t.date "release_date"
    t.decimal "sale_price", precision: 10, scale: 2
    t.integer "steam_app_id", null: false
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

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "games"
  add_foreign_key "carts", "users"
  add_foreign_key "game_genres", "games"
  add_foreign_key "game_genres", "genres"
  add_foreign_key "games", "categories"
  add_foreign_key "users", "provinces"
end
