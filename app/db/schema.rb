# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_22_091622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

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
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "color_museum_objects", force: :cascade do |t|
    t.integer "color_id"
    t.bigint "termlist_id"
    t.bigint "museum_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_color_museum_objects_on_museum_object_id"
    t.index ["termlist_id"], name: "index_color_museum_objects_on_termlist_id"
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

  create_table "dating_millennia_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_dating_millennium_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_dating_millennia_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_dating_millennium_id"], name: "index_dating_millennia_ms_koo_specs_on_dating_millennium_id"
  end

  create_table "dating_periods_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_dating_period_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_dating_periods_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_dating_period_id"], name: "index_dating_periods_ms_koo_specs_on_dating_period_koo_spec_id"
  end

  create_table "decoration_color_museum_objects", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.integer "decoration_color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["decoration_color_id"], name: "index_decoration_color_museum_objects_on_decoration_color_id"
    t.index ["museum_object_id"], name: "index_decoration_color_museum_objects_on_museum_object_id"
  end

  create_table "decoration_colors_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_decoration_color_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_deco_colors_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_decoration_color_id"], name: "index_deco_colors_ms_koo_specs_on_deco_color_id"
  end

  create_table "decoration_style_museum_objects", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.integer "decoration_style_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["decoration_style_id"], name: "index_decoration_style_museum_objects_on_decoration_style_id"
    t.index ["museum_object_id"], name: "index_decoration_style_museum_objects_on_museum_object_id"
  end

  create_table "decoration_technique_museum_objects", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.integer "decoration_technique_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["decoration_technique_id"], name: "index_decoration_tech_m_objects_on_decoration_tech_id"
    t.index ["museum_object_id"], name: "index_decoration_technique_museum_objects_on_museum_object_id"
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

  create_table "excavation_site_category_kinds", force: :cascade do |t|
    t.integer "excavation_site_category_id"
    t.integer "excavation_site_kind_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "excavation_sites", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inscription_language_museum_objects", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.integer "inscription_language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inscription_language_id"], name: "index_inscr_language_m_objects_on_inscr_language_id"
    t.index ["museum_object_id"], name: "index_inscription_language_museum_objects_on_museum_object_id"
  end

  create_table "inscription_languages_ms_koo_specs", force: :cascade do |t|
    t.bigint "termlist_inscription_language_id"
    t.bigint "material_specifieds_koo_spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specifieds_koo_spec_id"], name: "index_inscription_langs_ms_koo_specs_on_ms_koo_spec_id"
    t.index ["termlist_inscription_language_id"], name: "index_inscription_langs_ms_koo_specs_on_inscription_lang_id"
  end

  create_table "inscription_letter_museum_objects", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.integer "inscription_letter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inscription_letter_id"], name: "index_inscr_letter_m_objects_on_inscr_letter_id"
    t.index ["museum_object_id"], name: "index_inscription_letter_museum_objects_on_museum_object_id"
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

  create_table "loan_outs", force: :cascade do |t|
    t.string "to_institution"
    t.string "borrower_name"
    t.string "borrower_job_title"
    t.date "date_out"
    t.string "request_document_number"
    t.date "request_document_date"
    t.string "request_document_signed_by"
    t.string "lender_name"
    t.string "lender_job_title"
    t.string "loan_document_number"
    t.date "return_date"
    t.text "object_condition"
    t.bigint "museum_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "planned_return"
    t.text "return_condition"
    t.text "return_remarks"
    t.string "return_document_number"
    t.string "return_document_signed_by"
    t.index ["museum_object_id"], name: "index_loan_outs_on_museum_object_id"
  end

  create_table "material_museum_objects", force: :cascade do |t|
    t.bigint "material_id"
    t.bigint "museum_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_material_museum_objects_on_material_id"
    t.index ["museum_object_id"], name: "index_material_museum_objects_on_museum_object_id"
  end

  create_table "material_specified_museum_objects", force: :cascade do |t|
    t.bigint "material_specified_id"
    t.bigint "museum_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_specified_id"], name: "index_ms_museum_objects_on_ms_id"
    t.index ["museum_object_id"], name: "index_material_specified_museum_objects_on_museum_object_id"
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

  create_table "museum_object_paths", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.bigint "path_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_museum_object_paths_on_museum_object_id"
    t.index ["path_id"], name: "index_museum_object_paths_on_path_id"
  end

  create_table "museum_objects", id: :serial, force: :cascade do |t|
    t.string "inv_number"
    t.integer "inv_extension"
    t.string "inv_numberdoa"
    t.integer "amount"
    t.string "finding_context"
    t.text "finding_remarks"
    t.string "description_conservation"
    t.string "acquisition_deliverer_name"
    t.integer "storage_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "excavation_site_id"
    t.boolean "is_finished", default: false
    t.string "inscription_decoration"
    t.string "inscription_text"
    t.string "inscription_translation"
    t.string "priority_determined_by"
    t.float "max_length"
    t.float "max_width"
    t.float "height"
    t.float "opening_dm"
    t.float "bottom_dm"
    t.float "weight_in_gram"
    t.text "remarks"
    t.text "literature"
    t.string "acquisition_document_number"
    t.string "name_mega_jordan"
    t.string "name_expedition"
    t.string "site_number_mega"
    t.string "site_number_jadis"
    t.string "site_number_expedition"
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
    t.bigint "main_material_specified_id"
    t.integer "acquisition_year"
    t.integer "acquisition_month"
    t.integer "acquisition_day"
    t.integer "acquisition_kind_id"
    t.integer "acquisition_delivered_by_id"
    t.integer "excavation_site_kind_id"
    t.integer "kind_of_object_id"
    t.integer "main_path_id"
    t.integer "production_technique_id"
    t.integer "decoration_style_id"
    t.integer "decoration_technique_id"
    t.integer "decoration_color_id"
    t.integer "inscription_letter_id"
    t.integer "inscription_language_id"
    t.integer "preservation_material_id"
    t.integer "preservation_object_id"
    t.integer "authenticity_id"
    t.integer "priority_id"
    t.integer "dating_period_id"
    t.integer "dating_millennium_begin_id"
    t.integer "dating_millennium_end_id"
    t.boolean "is_dating_period_unknown"
    t.boolean "is_dating_millennium_unknown"
    t.boolean "is_dating_century_unknown"
    t.boolean "is_dating_timespan_unknown"
    t.integer "dating_century_begin_id"
    t.integer "dating_century_end_id"
    t.text "description"
    t.text "remarks_acquisition"
    t.integer "excavation_site_category_id"
    t.float "thickness"
    t.float "max_dm"
    t.string "munsell_color_of_object"
    t.index ["excavation_site_id"], name: "index_museum_objects_on_excavation_site_id"
    t.index ["main_material_specified_id"], name: "index_museum_objects_on_main_material_specified_id"
    t.index ["storage_location_id"], name: "index_museum_objects_on_storage_location_id"
  end

  create_table "museums", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefix"
  end

  create_table "paths", force: :cascade do |t|
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["path"], name: "index_paths_on_path", unique: true
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
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

  create_table "production_technique_museum_objects", force: :cascade do |t|
    t.bigint "museum_object_id"
    t.integer "production_technique_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["museum_object_id"], name: "index_production_technique_museum_objects_on_museum_object_id"
    t.index ["production_technique_id"], name: "index_prod_tech_m_objects_on_production_technique_id"
  end

  create_table "storage_locations", id: :serial, force: :cascade do |t|
    t.string "name_en"
    t.integer "storage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_ar"
    t.integer "position"
    t.index ["storage_id"], name: "index_storage_locations_on_storage_id"
  end

  create_table "storages", id: :serial, force: :cascade do |t|
    t.string "name_en"
    t.integer "museum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_ar"
    t.integer "position"
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

  create_table "termlist_paths", force: :cascade do |t|
    t.bigint "termlist_id"
    t.bigint "path_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["path_id"], name: "index_termlist_paths_on_path_id"
    t.index ["termlist_id", "path_id"], name: "index_termlist_paths_on_termlist_id_and_path_id", unique: true
    t.index ["termlist_id"], name: "index_termlist_paths_on_termlist_id"
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

  create_table "termlist_priorities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlist_production_techniques", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "termlists", force: :cascade do |t|
    t.string "type"
    t.string "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.string "name_ar"
  end

  create_table "translations", force: :cascade do |t|
    t.string "locale"
    t.string "key"
    t.text "value"
    t.text "interpolations"
    t.boolean "is_proc", default: false
    t.boolean "is_termlist", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "locale", default: "en", null: false
    t.binary "pdf_export"
    t.boolean "pdf_export_finished", default: false
    t.boolean "has_extended_access", default: false
    t.boolean "is_enabled", default: false, null: false
    t.boolean "pdf_export_running", default: false
    t.bigint "museum_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["museum_id"], name: "index_users_on_museum_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "color_museum_objects", "museum_objects"
  add_foreign_key "color_museum_objects", "termlists"
  add_foreign_key "colors_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "colors_ms_koo_specs", "termlist_colors"
  add_foreign_key "dating_centuries_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "dating_centuries_ms_koo_specs", "termlist_dating_centuries"
  add_foreign_key "dating_millennia_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "dating_millennia_ms_koo_specs", "termlist_dating_millennia"
  add_foreign_key "dating_periods_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "dating_periods_ms_koo_specs", "termlist_dating_periods"
  add_foreign_key "decoration_color_museum_objects", "museum_objects"
  add_foreign_key "decoration_color_museum_objects", "termlists", column: "decoration_color_id"
  add_foreign_key "decoration_colors_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "decoration_colors_ms_koo_specs", "termlist_decoration_colors"
  add_foreign_key "decoration_style_museum_objects", "museum_objects"
  add_foreign_key "decoration_style_museum_objects", "termlists", column: "decoration_style_id"
  add_foreign_key "decoration_technique_museum_objects", "museum_objects"
  add_foreign_key "decoration_technique_museum_objects", "termlists", column: "decoration_technique_id"
  add_foreign_key "decoration_techniques_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "decoration_techniques_ms_koo_specs", "termlist_decoration_techniques"
  add_foreign_key "decorations_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "decorations_ms_koo_specs", "termlist_decorations"
  add_foreign_key "excavation_site_category_kinds", "termlists", column: "excavation_site_category_id"
  add_foreign_key "excavation_site_category_kinds", "termlists", column: "excavation_site_kind_id"
  add_foreign_key "inscription_language_museum_objects", "museum_objects"
  add_foreign_key "inscription_language_museum_objects", "termlists", column: "inscription_language_id"
  add_foreign_key "inscription_languages_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "inscription_languages_ms_koo_specs", "termlist_inscription_languages"
  add_foreign_key "inscription_letter_museum_objects", "museum_objects"
  add_foreign_key "inscription_letter_museum_objects", "termlists", column: "inscription_letter_id"
  add_foreign_key "inscription_letters_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "inscription_letters_ms_koo_specs", "termlist_inscription_letters"
  add_foreign_key "join_museum_object_dating_centuries", "museum_objects"
  add_foreign_key "join_museum_object_dating_centuries", "termlist_dating_centuries"
  add_foreign_key "loan_outs", "museum_objects"
  add_foreign_key "material_museum_objects", "museum_objects"
  add_foreign_key "material_museum_objects", "termlists", column: "material_id"
  add_foreign_key "material_specified_museum_objects", "museum_objects"
  add_foreign_key "material_specified_museum_objects", "termlists", column: "material_specified_id"
  add_foreign_key "material_specifieds_koo_specs", "termlist_kind_of_object_specifieds"
  add_foreign_key "material_specifieds_koo_specs", "termlist_material_specifieds"
  add_foreign_key "museum_object_image_lists", "museum_objects"
  add_foreign_key "museum_object_images", "museum_objects"
  add_foreign_key "museum_object_paths", "museum_objects"
  add_foreign_key "museum_object_paths", "paths"
  add_foreign_key "museum_objects", "paths", column: "main_path_id"
  add_foreign_key "museum_objects", "termlist_material_specifieds", column: "main_material_specified_id"
  add_foreign_key "museum_objects", "termlists", column: "acquisition_delivered_by_id"
  add_foreign_key "museum_objects", "termlists", column: "acquisition_kind_id"
  add_foreign_key "museum_objects", "termlists", column: "authenticity_id"
  add_foreign_key "museum_objects", "termlists", column: "dating_century_begin_id"
  add_foreign_key "museum_objects", "termlists", column: "dating_century_end_id"
  add_foreign_key "museum_objects", "termlists", column: "dating_millennium_begin_id"
  add_foreign_key "museum_objects", "termlists", column: "dating_millennium_end_id"
  add_foreign_key "museum_objects", "termlists", column: "dating_period_id"
  add_foreign_key "museum_objects", "termlists", column: "decoration_color_id"
  add_foreign_key "museum_objects", "termlists", column: "decoration_style_id"
  add_foreign_key "museum_objects", "termlists", column: "decoration_technique_id"
  add_foreign_key "museum_objects", "termlists", column: "excavation_site_category_id"
  add_foreign_key "museum_objects", "termlists", column: "excavation_site_kind_id"
  add_foreign_key "museum_objects", "termlists", column: "inscription_language_id"
  add_foreign_key "museum_objects", "termlists", column: "inscription_letter_id"
  add_foreign_key "museum_objects", "termlists", column: "kind_of_object_id"
  add_foreign_key "museum_objects", "termlists", column: "preservation_material_id"
  add_foreign_key "museum_objects", "termlists", column: "preservation_object_id"
  add_foreign_key "museum_objects", "termlists", column: "priority_id"
  add_foreign_key "museum_objects", "termlists", column: "production_technique_id"
  add_foreign_key "preservation_materials_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "preservation_materials_ms_koo_specs", "termlist_preservation_materials"
  add_foreign_key "preservation_objects_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "preservation_objects_ms_koo_specs", "termlist_preservation_objects"
  add_foreign_key "prod_techs_ms_koo_specs", "material_specifieds_koo_specs"
  add_foreign_key "prod_techs_ms_koo_specs", "termlist_production_techniques"
  add_foreign_key "production_technique_museum_objects", "museum_objects"
  add_foreign_key "production_technique_museum_objects", "termlists", column: "production_technique_id"
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
  add_foreign_key "termlist_paths", "paths"
  add_foreign_key "termlist_paths", "termlists"
  add_foreign_key "users", "museums"
end
