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

ActiveRecord::Schema.define(version: 2016_03_21_040951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "folders", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "password_users", id: :serial, force: :cascade do |t|
    t.integer "password_id"
    t.integer "user_id"
    t.integer "permissions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["password_id"], name: "index_password_users_on_password_id"
    t.index ["user_id"], name: "index_password_users_on_user_id"
  end

  create_table "passwords", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "login"
    t.string "pass"
    t.string "url"
    t.text "notes"
    t.string "image"
    t.integer "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_passwords_on_folder_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "image"
    t.boolean "is_pirate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "authentication_token"
    t.index ["authentication_token"], name: "index_users_on_authentication_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "folders", "users"
  add_foreign_key "password_users", "passwords"
  add_foreign_key "password_users", "users"
  add_foreign_key "passwords", "folders"
end
