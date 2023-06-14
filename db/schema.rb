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

ActiveRecord::Schema.define(version: 2023_05_05_160917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string "name"
    t.string "place_id"
    t.string "place_name"
    t.boolean "recurring"
    t.time "time"
    t.date "date"
    t.string "notes"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.string "google_id"
    t.bigint "user_id"
    t.string "name"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "user_appointments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "appointment_id"
    t.boolean "owner"
    t.string "status", default: "none"
    t.index ["appointment_id"], name: "index_user_appointments_on_appointment_id"
    t.index ["user_id"], name: "index_user_appointments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "googleid"
    t.string "location"
    t.string "lat"
    t.string "long"
    t.integer "radius", default: 50000
    t.string "encrypted_token"
    t.string "encrypted_refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "favorites", "users"
  add_foreign_key "user_appointments", "appointments"
  add_foreign_key "user_appointments", "users"
end
