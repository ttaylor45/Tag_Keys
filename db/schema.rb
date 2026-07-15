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

ActiveRecord::Schema[8.1].define(version: 2026_07_15_233842) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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

  add_foreign_key "game_genres", "games"
  add_foreign_key "game_genres", "genres"
  add_foreign_key "games", "categories"
end
