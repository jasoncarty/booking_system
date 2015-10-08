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

ActiveRecord::Schema.define(version: 20151008173152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "event_attendees", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "reserve",    default: false
  end

  add_index "event_attendees", ["event_id"], name: "index_event_attendees_on_event_id", using: :btree
  add_index "event_attendees", ["user_id"], name: "index_event_attendees_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "title"
    t.string   "preview"
    t.integer  "calendar_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "maximum_event_attendees", default: 0
  end

  add_index "events", ["calendar_id"], name: "index_events_on_calendar_id", using: :btree
  add_index "events", ["starts_at"], name: "index_events_on_starts_at", using: :btree

  create_table "site_settings", force: :cascade do |t|
    t.string   "site_name"
    t.integer  "maximum_event_attendees", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "confirmed"
    t.datetime "confirmed_at"
    t.string   "verification_token"
    t.datetime "verification_sent_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_token_sent_at"
    t.string   "role",                         default: "user"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

end
