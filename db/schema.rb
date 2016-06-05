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

ActiveRecord::Schema.define(version: 20160605150457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "api_clients", force: :cascade do |t|
    t.string   "name"
    t.string   "encrypted_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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

  add_foreign_key "availability_schedules", "spots"
  add_foreign_key "pricing_schedules", "spots"
  add_foreign_key "spots", "establishments"
end
