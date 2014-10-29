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

ActiveRecord::Schema.define(version: 20141029020512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "country_id"
    t.integer  "region_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "population"
    t.string   "geonameid"
    t.string   "timezone"
    t.boolean  "capital",          default: false
    t.boolean  "capital_district", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree
  add_index "cities", ["geonameid"], name: "index_cities_on_geonameid", using: :btree
  add_index "cities", ["slug"], name: "index_cities_on_slug", using: :btree

  create_table "city_aliases", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "city_aliases", ["city_id"], name: "index_city_aliases_on_city_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "isocode"
    t.string   "geonameid"
    t.string   "population"
    t.string   "continent"
    t.string   "neighbours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["geonameid"], name: "index_countries_on_geonameid", unique: true, using: :btree
  add_index "countries", ["isocode"], name: "index_countries_on_iso_code", unique: true, using: :btree
  add_index "countries", ["isocode"], name: "index_countries_on_isocode", unique: true, using: :btree
  add_index "countries", ["slug"], name: "index_countries_on_slug", unique: true, using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.string   "geonameid"
    t.integer  "country_id"
    t.string   "concatenated_codes"
    t.string   "isocode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["geonameid"], name: "index_regions_on_geonameid", unique: true, using: :btree

end
