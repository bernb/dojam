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

ActiveRecord::Schema.define(version: 20170925083504) do

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
    t.string   "acquisition_delivered_by"
    t.string   "acquisition_kind_name"
    t.string   "acquisition_deliverer_name"
    t.string   "acquisition_date"
    t.integer  "ex_site_id"
    t.integer  "storage_location_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["ex_site_id"], name: "index_museum_objects_on_ex_site_id"
    t.index ["storage_location_id"], name: "index_museum_objects_on_storage_location_id"
  end

end
