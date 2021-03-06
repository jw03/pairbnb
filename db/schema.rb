# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161024035639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string "uid"
    t.string "token"
    t.string "provider"
    t.string "user_id"
  end

  create_table "available_dates", force: :cascade do |t|
    t.date     "date"
    t.boolean  "availability", default: true
    t.integer  "listing_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "listings", force: :cascade do |t|
    t.string   "title",           null: false
    t.text     "description",     null: false
    t.string   "address",         null: false
    t.string   "city",            null: false
    t.date     "available_from",  null: false
    t.date     "available_until", null: false
    t.integer  "price_day",       null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.json     "avatars"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "reservation_id"
    t.string   "braintree_payment_id"
    t.string   "status"
    t.string   "fourdigit"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "payments", ["reservation_id"], name: "index_payments_on_reservation_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.date     "check_in"
    t.date     "check_out"
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "first_name",                     null: false
    t.string   "last_name",                      null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.json     "avatars"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
