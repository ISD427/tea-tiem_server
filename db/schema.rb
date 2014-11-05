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

ActiveRecord::Schema.define(version: 20141105134410) do

  create_table "activities", force: true do |t|
    t.string   "user_id"
    t.string   "activity_code"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checks", force: true do |t|
    t.string   "user_id"
    t.string   "cafename"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.string   "source_id"
    t.string   "target_id"
    t.boolean  "first_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cafename"
    t.datetime "time"
  end

  create_table "messages", force: true do |t|
    t.string   "source_id"
    t.string   "target_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted"
  end

  create_table "statuses", force: true do |t|
    t.string   "user_id"
    t.string   "cafename"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: false, force: true do |t|
    t.string   "id",                 null: false
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex"
    t.string   "profile"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "age"
  end

  add_index "users", ["id"], name: "index_users_on_id", unique: true, using: :btree

end
