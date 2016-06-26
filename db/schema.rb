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

ActiveRecord::Schema.define(version: 20160619162958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "api_clients", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "token",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_api_clients_on_name", unique: true, using: :btree
    t.index ["token"], name: "index_api_clients_on_token", unique: true, using: :btree
  end

  create_table "availability_schedules", force: :cascade do |t|
    t.integer  "spot_id",      null: false
    t.integer  "from",         null: false
    t.integer  "to",           null: false
    t.time     "begin_time",   null: false
    t.time     "end_time",     null: false
    t.boolean  "is_available", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["spot_id"], name: "index_availability_schedules_on_spot_id", using: :btree
  end

  create_table "checkins", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.integer  "spot_id",        null: false
    t.datetime "checked_in_at",  null: false
    t.datetime "checked_out_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["spot_id"], name: "index_checkins_on_spot_id", using: :btree
    t.index ["user_id"], name: "index_checkins_on_user_id", using: :btree
  end

  create_table "establishments", force: :cascade do |t|
    t.string   "google_place_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pricing_schedules", force: :cascade do |t|
    t.integer  "spot_id",                            null: false
    t.integer  "from",                               null: false
    t.integer  "to",                                 null: false
    t.time     "begin_time",                         null: false
    t.time     "end_time",                           null: false
    t.decimal  "price",      precision: 6, scale: 2, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["spot_id"], name: "index_pricing_schedules_on_spot_id", using: :btree
  end

  create_table "spots", force: :cascade do |t|
    t.integer  "establishment_id"
    t.string   "parking_type",                               null: false
    t.integer  "status",                                     null: false
    t.boolean  "is_outdoor",                                 null: false
    t.boolean  "is_preferential",                            null: false
    t.decimal  "latitude",         precision: 15, scale: 12, null: false
    t.decimal  "longitude",        precision: 15, scale: 12, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index "ll_to_earth((latitude)::double precision, (longitude)::double precision)", name: "spots_earthdistance_ix", using: :gist
    t.index ["establishment_id"], name: "index_spots_on_establishment_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "availability_schedules", "spots"
  add_foreign_key "checkins", "spots"
  add_foreign_key "checkins", "users"
  add_foreign_key "pricing_schedules", "spots"
  add_foreign_key "spots", "establishments"
end
