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

ActiveRecord::Schema.define(version: 20161205122443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calls", force: :cascade do |t|
    t.string   "uuid"
    t.string   "caller_number"
    t.string   "caller_name"
    t.integer  "user_id"
    t.integer  "user_number_id"
    t.integer  "company_number_id"
    t.string   "record_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["company_number_id"], name: "index_calls_on_company_number_id", using: :btree
    t.index ["user_id"], name: "index_calls_on_user_id", using: :btree
    t.index ["user_number_id"], name: "index_calls_on_user_number_id", using: :btree
    t.index ["uuid"], name: "index_calls_on_uuid", unique: true, using: :btree
  end

  create_table "company_numbers", force: :cascade do |t|
    t.string   "sip_endpoint"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
  end

  create_table "company_numbers_users", id: false, force: :cascade do |t|
    t.integer "user_id",           null: false
    t.integer "company_number_id", null: false
    t.index ["company_number_id", "user_id"], name: "index_company_numbers_users_on_company_number_id_and_user_id", using: :btree
    t.index ["user_id", "company_number_id"], name: "index_company_numbers_users_on_user_id_and_company_number_id", using: :btree
  end

  create_table "user_numbers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "sip_endpoint"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.index ["user_id"], name: "index_user_numbers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "calls", "company_numbers"
  add_foreign_key "calls", "user_numbers"
  add_foreign_key "calls", "users"
  add_foreign_key "user_numbers", "users"
end
