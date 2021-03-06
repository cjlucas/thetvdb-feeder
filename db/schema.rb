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

ActiveRecord::Schema.define(version: 20140825183429) do

  create_table "episodes", force: true do |t|
    t.integer  "tvdb_id"
    t.string   "name"
    t.integer  "season_num"
    t.string   "episode_num"
    t.date     "airdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "series_id"
  end

  create_table "ical_settings", force: true do |t|
    t.integer  "user_id"
    t.integer  "start_offset"
    t.integer  "end_offset"
    t.integer  "summary_format"
    t.integer  "location_format"
    t.integer  "description_format"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timezone"
    t.boolean  "adjust_airtime"
  end

  add_index "ical_settings", ["user_id"], name: "index_ical_settings_on_user_id"

  create_table "series", force: true do |t|
    t.integer  "tvdb_id"
    t.string   "name"
    t.integer  "runtime"
    t.string   "airtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "series_id"
  end

  create_table "users", force: true do |t|
    t.string   "tvdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
    t.datetime "scanned_at"
  end

end
