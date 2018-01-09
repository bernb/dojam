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

ActiveRecord::Schema.define(version: 20180109170554) do

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

  create_table "join_museum_object_colors", force: :cascade do |t|
    t.integer  "termlist_color_id"
    t.integer  "museum_object_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["museum_object_id"], name: "index_join_museum_object_colors_on_museum_object_id"
    t.index ["termlist_color_id"], name: "index_join_museum_object_colors_on_termlist_color_id"
  end

  create_table "join_museum_object_material_specifieds", force: :cascade do |t|
    t.integer  "museum_object_id"
    t.integer  "termlist_material_specified_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["museum_object_id"], name: "index_join_museum_object"
    t.index ["termlist_material_specified_id"], name: "index_join_material_specified"
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
    t.string   "inscription_decoration"
    t.string   "inscription_text"
    t.string   "inscription_translation"
    t.integer  "termlist_authenticity_id"
    t.integer  "priority"
    t.string   "priority_determined_by"
    t.float    "remaining_length"
    t.float    "remaining_width"
    t.float    "remaining_height"
    t.float    "remaining_opening_dm"
    t.float    "remaining_bottom_dm"
    t.float    "remaining_weight_in_gram"
    t.text     "remarks"
    t.text     "literature"
    t.integer  "termlist_dating_millennium_id"
    t.integer  "termlist_kind_of_object_id"
    t.integer  "termlist_kind_of_object_specified_id"
    t.integer  "termlist_decoration_id"
    t.integer  "termlist_decoration_color_id"
    t.integer  "termlist_inscription_letter_id"
    t.integer  "termlist_inscription_language_id"
    t.integer  "termlist_decoration_technique_id"
    t.integer  "termlist_preservation_material_id"
    t.integer  "termlist_preservation_object_id"
    t.integer  "termlist_production_techniques_id"
    t.index ["excavation_site_id"], name: "index_museum_objects_on_excavation_site_id"
    t.index ["storage_location_id"], name: "index_museum_objects_on_storage_location_id"
    t.index ["termlist_acquisition_delivered_by_id"], name: "index_museum_objects_on_termlist_acquisition_delivered_by_id"
    t.index ["termlist_acquisition_kind_id"], name: "index_museum_objects_on_termlist_acquisition_kind_id"
    t.index ["termlist_authenticity_id"], name: "index_museum_objects_on_termlist_authenticity_id"
    t.index ["termlist_dating_millennium_id"], name: "index_museum_objects_on_termlist_dating_millennium_id"
    t.index ["termlist_decoration_color_id"], name: "index_museum_objects_on_termlist_decoration_color_id"
    t.index ["termlist_decoration_id"], name: "index_museum_objects_on_termlist_decoration_id"
    t.index ["termlist_decoration_technique_id"], name: "index_museum_objects_on_termlist_decoration_technique_id"
    t.index ["termlist_inscription_language_id"], name: "index_museum_objects_on_termlist_inscription_language_id"
    t.index ["termlist_inscription_letter_id"], name: "index_museum_objects_on_termlist_inscription_letter_id"
    t.index ["termlist_kind_of_object_id"], name: "index_museum_objects_on_termlist_kind_of_object_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_museum_objects_on_termlist_kind_of_object_specified_id"
    t.index ["termlist_preservation_material_id"], name: "index_museum_objects_on_termlist_preservation_material_id"
    t.index ["termlist_preservation_object_id"], name: "index_museum_objects_on_termlist_preservation_object_id"
    t.index ["termlist_production_techniques_id"], name: "index_museum_objects_on_termlist_production_techniques_id"
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

  create_table "termlist_authenticities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "termlist_kind_of_object_specified_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_termlist_colors_on_termlist_kind_of_object_specified_id"
  end

  create_table "termlist_conservations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_dating_millennia", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_dating_periods", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_decoration_colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "termlist_kind_of_object_specified_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_decoration_color_on_kind_of_object_specified"
  end

  create_table "termlist_decoration_techniques", force: :cascade do |t|
    t.string   "name"
    t.integer  "termlist_kind_of_object_specified_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["termlist_kind_of_object_specified_id"], name: "index_decoration_technique_on_museum_objects"
  end

  create_table "termlist_decorations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "termlist_kind_of_object_specified_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "decorations_on_kind_of_object_specified_id"
  end

  create_table "termlist_excavation_site_kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_inscription_languages", force: :cascade do |t|
    t.string   "name"
    t.integer  "termlist_material_specified_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["termlist_material_specified_id"], name: "index_inscription_languages_on_material_specified_id"
  end

  create_table "termlist_inscription_letters", force: :cascade do |t|
    t.string   "name"
    t.integer  "termlist_material_specified_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["termlist_material_specified_id"], name: "index_inscription_letters_on_material_specified_id"
  end

  create_table "termlist_kind_of_object_specifieds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "termlist_kind_of_object_id"
    t.index ["termlist_kind_of_object_id"], name: "index_kind_of_object_specifieds_on_kind_of_object_id"
  end

  create_table "termlist_kind_of_object_specifieds_production_techniques", id: false, force: :cascade do |t|
    t.integer "termlist_production_technique_id",     null: false
    t.integer "termlist_kind_of_object_specified_id", null: false
  end

  create_table "termlist_kind_of_objects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "termlist_material_specified_id"
    t.index ["termlist_material_specified_id"], name: "index_kind_of_objects_on_material_specified_id"
  end

  create_table "termlist_material_specifieds", force: :cascade do |t|
    t.string   "name"
    t.integer  "termlist_material_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["termlist_material_id"], name: "index_termlist_material_specifieds_on_termlist_material_id"
  end

  create_table "termlist_materials", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_preservation_materials", force: :cascade do |t|
    t.string   "name"
    t.integer  "termlist_kind_of_object_specified_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["termlist_kind_of_object_specified_id"], name: "preservation_materials_on_kind_of_object_specified"
  end

  create_table "termlist_preservation_objects", force: :cascade do |t|
    t.string   "name"
    t.integer  "termlist_kind_of_object_specified_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["termlist_kind_of_object_specified_id"], name: "index_preservation_object+_on_kind_of_object"
  end

  create_table "termlist_preservations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_production_techniques", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
