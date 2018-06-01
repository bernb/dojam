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

ActiveRecord::Schema.define(version: 2018_06_01_115400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "colors_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_color_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_colors_ms_koo_specs_on_material_specifieds_koo_spec_id"
    t.index ["termlist_color_id"], name: "index_colors_ms_koo_specs_on_termlist_color_id"
  end

  create_table "dating_centuries_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_dating_century_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_dating_centuries_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_dating_century_id"], name: "index_dating_centuries_ms_koo_specs_on_dating_century_id"
  end

  create_table "decoration_colors_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_decoration_color_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_deco_colors_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_decoration_color_id"], name: "index_deco_colors_ms_koo_specs_on_deco_color_id"
  end

  create_table "decoration_techniques_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_decoration_technique_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_deco_techs_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_decoration_technique_id"], name: "index_deco_techs_ms_koo_specs_on_decoration_technique_id"
  end

  create_table "decorations_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_decoration_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_decorations_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_decoration_id"], name: "index_decorations_ms_koo_specs_on_decoration_id"
  end

  create_table "excavation_sites", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inscription_languages_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_inscription_language_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_inscription_langs_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_inscription_language_id"], name: "index_inscription_langs_ms_koo_specs_on_inscription_lang_id"
  end

  create_table "inscription_letters_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_inscription_letter_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_inscription_letters_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_inscription_letter_id"], name: "index_inscription_letters_ms_koo_specs_on_inscription_letter_id"
  end

  create_table "join_museum_object_colors", id: :serial, force: :cascade do |t|
    t.integer "termlist_color_id"
    t.integer "museum_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_join_museum_object_colors_on_museum_object_id"
    t.index ["termlist_color_id"], name: "index_join_museum_object_colors_on_termlist_color_id"
  end

  create_table "join_museum_object_dating_centuries", id: :serial, force: :cascade do |t|
    t.integer "museum_object_id"
    t.integer "termlist_dating_century_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_join_museum_object_dating_centuries_on_museum_object_id"
    t.index ["termlist_dating_century_id"], name: "index_join_mo_dating_centuries_on_dating_century_id"
  end

  create_table "join_museum_object_material_specifieds", id: :serial, force: :cascade do |t|
    t.integer "museum_object_id"
    t.integer "termlist_material_specified_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_join_museum_object"
    t.index ["termlist_material_specified_id"], name: "index_join_material_specified"
  end

  create_table "material_specifieds_koo_specs", force: :cascade do |t|
    t.bigint "termlist_material_specified_id"
    t.bigint "termlist_kind_of_object_specified_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_kind_of_object_specified_id"], name: "index_material_specifieds_koo_specs_on_koos_id"
    t.index ["termlist_material_specified_id", "termlist_kind_of_object_specified_id"], name: "index_ms_koo_specs_on_ms_id_and_koos_id", unique: true
    t.index ["termlist_material_specified_id"], name: "index_material_specifieds_koo_specs_on_material_specified_id"
  end

  create_table "museum_object_image_lists", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_museum_object_image_lists_on_museum_object_id"
  end

  create_table "museum_object_images", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_museum_object_images_on_museum_object_id"
  end

  create_table "museum_objects", id: :serial, force: :cascade do |t|
    t.string "inv_number"
    t.integer "inv_extension"
    t.string "inv_numberdoa"
    t.integer "amount"
    t.string "finding_context"
    t.text "finding_remarks"
    t.string "description_authenticities_name"
    t.string "description_conservation"
    t.string "description_preservation_state_name"
    t.string "acquisition_deliverer_name"
    t.integer "storage_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "termlist_acquisition_delivered_by_id"
    t.integer "termlist_acquisition_kind_id"
    t.integer "excavation_site_id"
    t.date "acquisition_date"
    t.boolean "is_finished", default: false
    t.string "inscription_decoration"
    t.string "inscription_text"
    t.string "inscription_translation"
    t.integer "termlist_authenticity_id"
    t.integer "priority"
    t.string "priority_determined_by"
    t.float "remaining_length"
    t.float "remaining_width"
    t.float "remaining_height"
    t.float "remaining_opening_dm"
    t.float "remaining_bottom_dm"
    t.float "remaining_weight_in_gram"
    t.text "remarks"
    t.text "literature"
    t.integer "termlist_dating_millennium_id"
    t.integer "termlist_kind_of_object_id"
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_decoration_id"
    t.integer "termlist_decoration_color_id"
    t.integer "termlist_inscription_letter_id"
    t.integer "termlist_inscription_language_id"
    t.integer "termlist_decoration_technique_id"
    t.integer "termlist_preservation_material_id"
    t.integer "termlist_preservation_object_id"
    t.string "acquisition_document_number"
    t.string "name_mega_jordan"
    t.string "name_expedition"
    t.string "site_number_mega"
    t.string "site_number_jadis"
    t.string "site_number_expedition"
    t.string "coordinates_mega"
    t.integer "termlist_production_technique_id"
    t.integer "termlist_dating_period_id"
    t.integer "termlist_excavation_site_kind_id"
    t.date "dating_timespan_begin"
    t.date "dating_timespan_end"
    t.json "images"
    t.boolean "is_used", default: false
    t.string "current_build_step", default: "initial"
    t.integer "acquisition_date_precision"
    t.string "coordinates_mega_long"
    t.string "coordinates_mega_lat"
    t.string "munsell_color"
    t.boolean "needs_cleaning"
    t.boolean "needs_conservation"
    t.boolean "is_dating_timespan_begin_BC"
    t.boolean "is_dating_timespan_end_BC"
    t.index ["excavation_site_id"], name: "index_museum_objects_on_excavation_site_id"
    t.index ["storage_location_id"], name: "index_museum_objects_on_storage_location_id"
    t.index ["termlist_acquisition_delivered_by_id"], name: "index_museum_objects_on_termlist_acquisition_delivered_by_id"
    t.index ["termlist_acquisition_kind_id"], name: "index_museum_objects_on_termlist_acquisition_kind_id"
    t.index ["termlist_authenticity_id"], name: "index_museum_objects_on_termlist_authenticity_id"
    t.index ["termlist_dating_millennium_id"], name: "index_museum_objects_on_termlist_dating_millennium_id"
    t.index ["termlist_dating_period_id"], name: "index_museum_objects_on_termlist_dating_period_id"
    t.index ["termlist_decoration_color_id"], name: "index_museum_objects_on_termlist_decoration_color_id"
    t.index ["termlist_decoration_id"], name: "index_museum_objects_on_termlist_decoration_id"
    t.index ["termlist_decoration_technique_id"], name: "index_museum_objects_on_termlist_decoration_technique_id"
    t.index ["termlist_excavation_site_kind_id"], name: "index_museum_objects_on_termlist_excavation_site_kind_id"
    t.index ["termlist_inscription_language_id"], name: "index_museum_objects_on_termlist_inscription_language_id"
    t.index ["termlist_inscription_letter_id"], name: "index_museum_objects_on_termlist_inscription_letter_id"
    t.index ["termlist_kind_of_object_id"], name: "index_museum_objects_on_termlist_kind_of_object_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_museum_objects_on_termlist_kind_of_object_specified_id"
    t.index ["termlist_preservation_material_id"], name: "index_museum_objects_on_termlist_preservation_material_id"
    t.index ["termlist_preservation_object_id"], name: "index_museum_objects_on_termlist_preservation_object_id"
    t.index ["termlist_production_technique_id"], name: "index_museum_objects_on_termlist_production_technique_id"
  end

  create_table "museums", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefix"
  end

  create_table "preservation_materials_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_preservation_material_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_preservation_m_ms_koo_specs_on_ms_koo_specs_id"
    t.index ["termlist_preservation_material_id"], name: "index_preservation_m_ms_koo_specs_on_preservation_m_id"
  end

  create_table "preservation_objects_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_preservation_object_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_pres_objects_ms_koo_specs_ms_koo_specs_id"
    t.index ["termlist_preservation_object_id"], name: "index_pres_objects_ms_koo_specs_on_pres_object_id"
  end

  create_table "prod_techs_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_production_technique_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_prod_techs_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_production_technique_id"], name: "index_prod_techs_ms_koo_specs_on_prod_tech_id"
  end

  create_table "storage_locations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "storage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["storage_id"], name: "index_storage_locations_on_storage_id"
  end

  create_table "storages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "museum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_id"], name: "index_storages_on_museum_id"
  end

  create_table "termlist_acquisition_delivered_bies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_acquisition_kinds", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_authenticities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_colors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_conservations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_dating_centuries", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "termlist_dating_millennia", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "termlist_dating_periods", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "termlist_decoration_colors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_decoration_techniques", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_decorations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_excavation_site_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_excavation_site_kinds", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "termlist_excavation_site_category_id"
    t.index ["termlist_excavation_site_category_id"], name: "index_ex_site_kinds_on_ex_site_category_id"
  end

  create_table "termlist_inscription_languages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_inscription_letters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_kind_of_object_specifieds", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "termlist_kind_of_object_id"
    t.index ["termlist_kind_of_object_id"], name: "index_kind_of_object_specifieds_on_kind_of_object_id"
  end

  create_table "termlist_kind_of_object_specifieds_colors", id: :serial, force: :cascade do |t|
    t.integer "termlist_color_id"
    t.integer "termlist_kind_of_object_specified_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_color_id"], name: "index_kind_of_object_specifieds_colors_on_color_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_kind_of_object_spec_colors_on_kind_of_object_spec_id"
  end

  create_table "termlist_kind_of_object_specifieds_dating_centuries", id: :serial, force: :cascade do |t|
    t.integer "termlist_dating_century_id"
    t.integer "termlist_kind_of_object_specified_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_dating_century_id"], name: "index_tkoos_dating_centuries_on_dating_century_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_koos_dating_centuries_on_koos_id"
  end

  create_table "termlist_kind_of_object_specifieds_dating_millennia", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_dating_millennium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_dating_millennium_id"], name: "index_koos_dating_millennia_on_termlist_dating_millennium_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_koos_dating_millennia_on_koos_id"
  end

  create_table "termlist_kind_of_object_specifieds_dating_periods", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_dating_period_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_dating_period_id"], name: "index_koos_dating_periods_on_termlist_dating_periods_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_koos_dating_periods_on_koos_id"
  end

  create_table "termlist_kind_of_object_specifieds_decoration_colors", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "termlist_decoration_color_id"
    t.index ["termlist_decoration_color_id"], name: "index_join_table_on_termlist_decoration_color_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_join_table_on_kind_of_object_spec_id"
  end

  create_table "termlist_kind_of_object_specifieds_decoration_techniques", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_decoration_technique_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_decoration_technique_id"], name: "index_join_table_on_termlist_decoration_technique_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_join_table_on_termlist_kind_of_object_specified_id"
  end

  create_table "termlist_kind_of_object_specifieds_decorations", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_decoration_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_decoration_id"], name: "index_join_table_on_decoration"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_join_table_on_kind_of_object_specified"
  end

  create_table "termlist_kind_of_object_specifieds_inscription_languages", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_inscription_language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_inscription_language_id"], name: "index_koos_inscription_languages_on_inscription_language_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_koos_inscription_languages_on_koos_id"
  end

  create_table "termlist_kind_of_object_specifieds_inscription_letters", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_inscription_letter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_inscription_letter_id"], name: "index_koos_inscription_letters_on_inscription_letter_id"
    t.index ["termlist_kind_of_object_specified_id"], name: "index_koos_inscription_letters_on_koos_id"
  end

  create_table "termlist_kind_of_object_specifieds_preservation_materials", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_preservation_material_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_kind_of_object_specified_id"], name: "index_join_table_koos_preservation_materials_on_koos_id"
    t.index ["termlist_preservation_material_id"], name: "index_join_table_koos_pres_materials_on_pres_material_id"
  end

  create_table "termlist_kind_of_object_specifieds_preservation_objects", id: :serial, force: :cascade do |t|
    t.integer "termlist_kind_of_object_specified_id"
    t.integer "termlist_preservation_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_kind_of_object_specified_id"], name: "index_koos_preservation_objects_on_koos_id"
    t.index ["termlist_preservation_object_id"], name: "index_koos_preservation_objects_on_preservation_material_id"
  end

  create_table "termlist_kind_of_object_specifieds_production_techniques", force: :cascade do |t|
    t.integer "termlist_production_technique_id", null: false
    t.integer "termlist_kind_of_object_specified_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_kind_of_object_specified_id"], name: "index_koos_on_production_technique_id"
    t.index ["termlist_production_technique_id"], name: "index_koos_production_techniques_on_production_technique_id"
  end

  create_table "termlist_kind_of_objects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "termlist_material_specified_id"
    t.index ["termlist_material_specified_id"], name: "index_kind_of_objects_on_material_specified_id"
  end

  create_table "termlist_material_specifieds", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "termlist_material_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["termlist_material_id"], name: "index_termlist_material_specifieds_on_termlist_material_id"
  end

  create_table "termlist_materials", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_preservation_materials", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_preservation_objects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_production_techniques", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "colors_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "colors_ms_koo_specs", "termlist_colors"
  add_foreign_key "dating_centuries_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "dating_centuries_ms_koo_specs", "termlist_dating_centuries"
  add_foreign_key "decoration_colors_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "decoration_colors_ms_koo_specs", "termlist_decoration_colors"
  add_foreign_key "decoration_techniques_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "decoration_techniques_ms_koo_specs", "termlist_decoration_techniques"
  add_foreign_key "decorations_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "decorations_ms_koo_specs", "termlist_decorations"
  add_foreign_key "inscription_languages_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "inscription_languages_ms_koo_specs", "termlist_inscription_languages"
  add_foreign_key "inscription_letters_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "inscription_letters_ms_koo_specs", "termlist_inscription_letters"
  add_foreign_key "join_museum_object_dating_centuries", "museum_objects"
  add_foreign_key "join_museum_object_dating_centuries", "termlist_dating_centuries"
  add_foreign_key "material_specifieds_koo_specs", "termlist_kind_of_object_specifieds"
  add_foreign_key "material_specifieds_koo_specs", "termlist_material_specifieds"
  add_foreign_key "museum_object_image_lists", "museum_objects"
  add_foreign_key "museum_object_images", "museum_objects"
  add_foreign_key "museum_objects", "termlist_dating_periods"
  add_foreign_key "museum_objects", "termlist_excavation_site_kinds"
  add_foreign_key "museum_objects", "termlist_production_techniques"
  add_foreign_key "preservation_materials_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "preservation_materials_ms_koo_specs", "termlist_preservation_materials"
  add_foreign_key "preservation_objects_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "preservation_objects_ms_koo_specs", "termlist_preservation_objects"
  add_foreign_key "prod_techs_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "prod_techs_ms_koo_specs", "termlist_production_techniques"
  add_foreign_key "termlist_kind_of_object_specifieds_dating_centuries", "termlist_dating_centuries"
  add_foreign_key "termlist_kind_of_object_specifieds_dating_centuries", "termlist_kind_of_object_specifieds"
  add_foreign_key "termlist_kind_of_object_specifieds_dating_millennia", "termlist_dating_millennia"
  add_foreign_key "termlist_kind_of_object_specifieds_dating_millennia", "termlist_kind_of_object_specifieds"
  add_foreign_key "termlist_kind_of_object_specifieds_dating_periods", "termlist_dating_periods"
  add_foreign_key "termlist_kind_of_object_specifieds_dating_periods", "termlist_kind_of_object_specifieds"
  add_foreign_key "termlist_kind_of_object_specifieds_inscription_languages", "termlist_inscription_languages"
  add_foreign_key "termlist_kind_of_object_specifieds_inscription_languages", "termlist_kind_of_object_specifieds"
  add_foreign_key "termlist_kind_of_object_specifieds_inscription_letters", "termlist_inscription_letters"
  add_foreign_key "termlist_kind_of_object_specifieds_inscription_letters", "termlist_kind_of_object_specifieds"
end
