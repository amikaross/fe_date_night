# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_05_04_172901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dates", force: :cascade do |t|
    t.string "name"
    t.string "place_id"
    t.boolean "recurring"
    t.time "time"
    t.date "date"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_dates", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "date_id"
    t.boolean "owner"
    t.index ["date_id"], name: "index_user_dates_on_date_id"
    t.index ["user_id"], name: "index_user_dates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "googleid"
    t.string "location"
    t.string "lat"
    t.string "long"
    t.integer "radius"
    t.string "encrypted_token"
    t.string "encrypted_refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "user_dates", "dates"
  add_foreign_key "user_dates", "users"
end
