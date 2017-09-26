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

ActiveRecord::Schema.define(version: 20170926125918) do

  create_table "excavation_sites", force: :cascade do |t|
    t.string   "name"
    t.string   "name_mega_jordan"
    t.string   "name_expedition"
    t.integer  "site_number_mega"
    t.integer  "site_number_jadis"
    t.integer  "site_number_expedition"
    t.string   "coordinates_mega"
    t.integer  "excavation_site_kind_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["excavation_site_kind_id"], name: "index_excavation_sites_on_excavation_site_kind_id"
  end

  create_table "museum_objects", force: :cascade do |t|
    t.integer  "inv_number"
    t.integer  "inv_extension"
    t.string   "inv_numberdoa"
    t.integer  "amount"
    t.string   "finding_context"
    t.text     "finding_remarks"
    t.string   "description_authenticities_name"
    t.string   "description_conservation"
    t.string   "description_preservation_state_name"
    t.string   "acquisition_deliverer_name"
    t.integer  "storage_location_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "termlist_acquisition_delivered_by_id"
    t.integer  "termlist_acquisition_kind_id"
    t.integer  "excavation_site_id"
    t.date     "acquisition_date"
    t.boolean  "is_finished",                          default: false
    t.index ["excavation_site_id"], name: "index_museum_objects_on_excavation_site_id"
    t.index ["storage_location_id"], name: "index_museum_objects_on_storage_location_id"
    t.index ["termlist_acquisition_delivered_by_id"], name: "index_museum_objects_on_termlist_acquisition_delivered_by_id"
    t.index ["termlist_acquisition_kind_id"], name: "index_museum_objects_on_termlist_acquisition_kind_id"
  end

  create_table "museums", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "prefix"
  end

  create_table "storage_locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "storage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["storage_id"], name: "index_storage_locations_on_storage_id"
  end

  create_table "storages", force: :cascade do |t|
    t.string   "name"
    t.integer  "museum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_id"], name: "index_storages_on_museum_id"
  end

  create_table "termlist_acquisition_delivered_bies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_acquisition_kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_excavation_site_kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
