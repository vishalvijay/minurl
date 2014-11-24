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

ActiveRecord::Schema.define(version: 20141122190736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "min_url_requests", force: true do |t|
    t.string   "ip"
    t.string   "ref_url"
    t.string   "browser"
    t.string   "platform"
    t.string   "country"
    t.integer  "min_url_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "min_url_requests", ["min_url_id"], name: "index_min_url_requests_on_min_url_id", using: :btree

  create_table "min_urls", force: true do |t|
    t.string   "url",         null: false
    t.string   "token",       null: false
    t.string   "token_alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "min_urls", ["token"], name: "index_min_urls_on_token", unique: true, using: :btree
  add_index "min_urls", ["token_alias"], name: "index_min_urls_on_token_alias", unique: true, using: :btree
  add_index "min_urls", ["url"], name: "index_min_urls_on_url", unique: true, using: :btree

end
