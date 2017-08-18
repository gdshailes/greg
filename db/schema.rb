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

ActiveRecord::Schema.define(version: 20170818110020) do

  create_table "api_subscriptions", force: :cascade do |t|
    t.string   "target_url"
    t.string   "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boris_cam_images", force: :cascade do |t|
    t.string   "filename"
    t.binary   "filedata"
    t.string   "filetype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diary_entries", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ride_log_bikes", force: :cascade do |t|
    t.string   "name",       default: "New Bike"
    t.string   "details"
    t.boolean  "current",    default: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "ride_log_images", force: :cascade do |t|
    t.string   "title"
    t.binary   "image"
    t.binary   "thumbnail"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_type", "imageable_id"], name: "index_ride_log_images_on_imageable_type_and_imageable_id"
  end

  create_table "ride_log_rides", force: :cascade do |t|
    t.integer  "ride_log_bike_id"
    t.string   "name",             default: "New Ride"
    t.datetime "date"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["ride_log_bike_id"], name: "index_ride_log_rides_on_ride_log_bike_id"
  end

end
