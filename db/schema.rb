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

ActiveRecord::Schema[7.0].define(version: 2023_12_22_053923) do
  create_table "domains", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "host"
    t.integer "user_users_id"
    t.index ["user_users_id"], name: "index_domains_on_user_users_id"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.binary "key", limit: 1024, null: false
    t.binary "value", limit: 536870912, null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_solid_cache_entries_on_key", unique: true
  end

  create_table "user_credentials", force: :cascade do |t|
    t.string "webauthn_id"
    t.string "public_key"
    t.integer "sign_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_users_id"
    t.string "name"
    t.index ["user_users_id"], name: "index_user_credentials_on_user_users_id"
  end

  create_table "user_users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "webauthn_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified"
    t.string "hotp_token"
    t.integer "otp_counter"
    t.integer "otp_last_minted"
    t.boolean "admin"
    t.boolean "disable_email_auth"
  end

  add_foreign_key "domains", "user_users", column: "user_users_id"
  add_foreign_key "user_credentials", "user_users", column: "user_users_id"
end
