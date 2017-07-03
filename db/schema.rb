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

ActiveRecord::Schema.define(version: 20170702061908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "client_email"
    t.integer  "price"
    t.integer  "rental_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["rental_id"], name: "index_bookings_on_rental_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "rental_ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rental_id"
    t.decimal  "stars"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rental_id"], name: "index_rental_ratings_on_rental_id", using: :btree
    t.index ["user_id"], name: "index_rental_ratings_on_user_id", using: :btree
  end

  create_table "rentals", force: :cascade do |t|
    t.string   "name"
    t.integer  "daily_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "bookings", "rentals"
  add_foreign_key "bookings", "users"
  add_foreign_key "rental_ratings", "rentals"
  add_foreign_key "rental_ratings", "users"
end
