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

ActiveRecord::Schema.define(version: 20190215111900) do

  create_table "boris_cam_images", force: :cascade do |t|
    t.string   "filename"
    t.binary   "filedata"
    t.string   "filetype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "comment"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "diary_entries", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_diary_entries_on_user_id"
  end

  create_table "finances_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "opening_balance_pence",       default: 0,     null: false
    t.string   "opening_balance_currency",    default: "GBP", null: false
    t.boolean  "primary",                                     null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "reconciled_balance_pence"
    t.string   "reconciled_balance_currency", default: "GBP", null: false
    t.index ["user_id"], name: "index_finances_accounts_on_user_id"
  end

  create_table "finances_bills", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "description",                     null: false
    t.integer  "amount_pence",    default: 0,     null: false
    t.string   "amount_currency", default: "GBP", null: false
    t.string   "frequency",                       null: false
    t.integer  "interval",                        null: false
    t.date     "next_due_at",                     null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["account_id"], name: "index_finances_bills_on_account_id"
  end

  create_table "finances_transactions", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "description"
    t.integer  "amount_pence",     default: 0,     null: false
    t.string   "amount_currency",  default: "GBP", null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.date     "transaction_date"
    t.string   "type"
    t.index ["account_id"], name: "index_finances_transactions_on_account_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.string   "filename"
    t.binary   "filedata"
    t.string   "filetype"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ratrace_posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_ratrace_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "administrator"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.text     "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
