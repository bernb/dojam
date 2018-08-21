require "administrate/base_dashboard"

class MuseumObjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    images: Field::String.with_options(searchable: false),
    excavation_site: Field::BelongsTo,
    storage_location: Field::BelongsTo,
    acquisition_delivered_by: Field::BelongsTo,
    acquisition_kind: Field::BelongsTo,
    authenticity: Field::BelongsTo,
    dating_millennium_begin: Field::BelongsTo.with_options(class_name: "DatingMillennium"),
    dating_millennium_end: Field::BelongsTo.with_options(class_name: "DatingMillennium"),
    dating_century_begin: Field::BelongsTo.with_options(class_name: "DatingCentury"),
    dating_century_end: Field::BelongsTo.with_options(class_name: "DatingCentury"),
    dating_period: Field::BelongsTo,
    production_technique: Field::BelongsTo,
    decoration_technique: Field::BelongsTo,
    decoration_color: Field::BelongsTo,
    decoration_style: Field::BelongsTo,
    preservation_material: Field::BelongsTo,
    preservation_object: Field::BelongsTo,
    inscription_letter: Field::BelongsTo,
    inscription_language: Field::BelongsTo,
    excavation_site_kind: Field::BelongsTo,
    priority: Field::BelongsTo,
    museum_object_paths: Field::HasMany,
    paths: Field::HasMany,
    color_museum_objects: Field::HasMany,
    colors: Field::HasMany,
    main_path: Field::BelongsTo.with_options(class_name: "Path"),
    id: Field::Number,
    inv_number: Field::String,
    inv_extension: Field::Number,
    inv_numberdoa: Field::String,
    amount: Field::Number,
    finding_context: Field::String,
    finding_remarks: Field::Text,
    description_authenticities_name: Field::String,
    description_conservation: Field::String,
    description_preservation_state_name: Field::String,
    acquisition_deliverer_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    termlist_acquisition_delivered_by_id: Field::Number,
    termlist_acquisition_kind_id: Field::Number,
    is_finished: Field::Boolean,
    inscription_decoration: Field::String,
    inscription_text: Field::String,
    inscription_translation: Field::String,
    termlist_authenticity_id: Field::Number,
    priority_determined_by: Field::String,
    max_length: Field::Number.with_options(decimals: 2),
    max_width: Field::Number.with_options(decimals: 2),
    height: Field::Number.with_options(decimals: 2),
    opening_dm: Field::Number.with_options(decimals: 2),
    bottom_dm: Field::Number.with_options(decimals: 2),
    weight_in_gram: Field::Number.with_options(decimals: 2),
    remarks: Field::Text,
    literature: Field::Text,
    termlist_dating_millennium_id: Field::Number,
    termlist_kind_of_object_id: Field::Number,
    termlist_kind_of_object_specified_id: Field::Number,
    termlist_decoration_id: Field::Number,
    termlist_decoration_color_id: Field::Number,
    termlist_inscription_letter_id: Field::Number,
    termlist_inscription_language_id: Field::Number,
    termlist_decoration_technique_id: Field::Number,
    termlist_preservation_material_id: Field::Number,
    termlist_preservation_object_id: Field::Number,
    acquisition_document_number: Field::String,
    name_mega_jordan: Field::String,
    name_expedition: Field::String,
    site_number_mega: Field::String,
    site_number_jadis: Field::String,
    site_number_expedition: Field::String,
    coordinates_mega: Field::String,
    termlist_production_technique_id: Field::Number,
    termlist_dating_period_id: Field::Number,
    termlist_excavation_site_kind_id: Field::Number,
    dating_timespan_begin: Field::DateTime,
    dating_timespan_end: Field::DateTime,
    images: Field::String.with_options(searchable: false),
    is_used: Field::Boolean,
    current_build_step: Field::String,
    acquisition_date_precision: Field::Number,
    coordinates_mega_long: Field::String,
    coordinates_mega_lat: Field::String,
    munsell_color: Field::String,
    needs_cleaning: Field::Boolean,
    needs_conservation: Field::Boolean,
    is_dating_timespan_begin_BC: Field::Boolean,
    is_dating_timespan_end_BC: Field::Boolean,
    main_material_specified_id: Field::Number,
    termlist_material_specified_id: Field::Number,
    termlist_priority_id: Field::Number,
    acquisition_year: Field::Number,
    acquisition_month: Field::Number,
    acquisition_day: Field::Number,
    kind_of_object_id: Field::Number,
    main_path_id: Field::Number,
    dating_millennium_begin_id: Field::Number,
    dating_millennium_end_id: Field::Number,
    is_dating_millennium_begin_bc: Field::Boolean,
    is_dating_millennium_end_bc: Field::Boolean,
    is_dating_century_begin_bc: Field::Boolean,
    is_dating_century_end_bc: Field::Boolean,
    is_dating_period_unknown: Field::Boolean,
    is_dating_millennium_unknown: Field::Boolean,
    is_dating_century_unknown: Field::Boolean,
    is_dating_timespan_unknown: Field::Boolean,
    dating_century_begin_id: Field::Number,
    dating_century_end_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :images,
    :excavation_site,
    :storage_location,
    :acquisition_delivered_by,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :images,
    :excavation_site,
    :storage_location,
    :acquisition_delivered_by,
    :acquisition_kind,
    :authenticity,
    :dating_millennium_begin,
    :dating_millennium_end,
    :dating_century_begin,
    :dating_century_end,
    :dating_period,
    :production_technique,
    :decoration_technique,
    :decoration_color,
    :decoration_style,
    :preservation_material,
    :preservation_object,
    :inscription_letter,
    :inscription_language,
    :excavation_site_kind,
    :priority,
    :museum_object_paths,
    :paths,
    :color_museum_objects,
    :colors,
    :main_path,
    :id,
    :inv_number,
    :inv_extension,
    :inv_numberdoa,
    :amount,
    :finding_context,
    :finding_remarks,
    :description_authenticities_name,
    :description_conservation,
    :description_preservation_state_name,
    :acquisition_deliverer_name,
    :created_at,
    :updated_at,
    :termlist_acquisition_delivered_by_id,
    :termlist_acquisition_kind_id,
    :is_finished,
    :inscription_decoration,
    :inscription_text,
    :inscription_translation,
    :termlist_authenticity_id,
    :priority_determined_by,
    :max_length,
    :max_width,
    :height,
    :opening_dm,
    :bottom_dm,
    :weight_in_gram,
    :remarks,
    :literature,
    :termlist_dating_millennium_id,
    :termlist_kind_of_object_id,
    :termlist_kind_of_object_specified_id,
    :termlist_decoration_id,
    :termlist_decoration_color_id,
    :termlist_inscription_letter_id,
    :termlist_inscription_language_id,
    :termlist_decoration_technique_id,
    :termlist_preservation_material_id,
    :termlist_preservation_object_id,
    :acquisition_document_number,
    :name_mega_jordan,
    :name_expedition,
    :site_number_mega,
    :site_number_jadis,
    :site_number_expedition,
    :coordinates_mega,
    :termlist_production_technique_id,
    :termlist_dating_period_id,
    :termlist_excavation_site_kind_id,
    :dating_timespan_begin,
    :dating_timespan_end,
    :images,
    :is_used,
    :current_build_step,
    :acquisition_date_precision,
    :coordinates_mega_long,
    :coordinates_mega_lat,
    :munsell_color,
    :needs_cleaning,
    :needs_conservation,
    :is_dating_timespan_begin_BC,
    :is_dating_timespan_end_BC,
    :main_material_specified_id,
    :termlist_material_specified_id,
    :termlist_priority_id,
    :acquisition_year,
    :acquisition_month,
    :acquisition_day,
    :kind_of_object_id,
    :main_path_id,
    :dating_millennium_begin_id,
    :dating_millennium_end_id,
    :is_dating_millennium_begin_bc,
    :is_dating_millennium_end_bc,
    :is_dating_century_begin_bc,
    :is_dating_century_end_bc,
    :is_dating_period_unknown,
    :is_dating_millennium_unknown,
    :is_dating_century_unknown,
    :is_dating_timespan_unknown,
    :dating_century_begin_id,
    :dating_century_end_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :images,
    :excavation_site,
    :storage_location,
    :acquisition_delivered_by,
    :acquisition_kind,
    :authenticity,
    :dating_millennium_begin,
    :dating_millennium_end,
    :dating_century_begin,
    :dating_century_end,
    :dating_period,
    :production_technique,
    :decoration_technique,
    :decoration_color,
    :decoration_style,
    :preservation_material,
    :preservation_object,
    :inscription_letter,
    :inscription_language,
    :excavation_site_kind,
    :priority,
    :museum_object_paths,
    :paths,
    :color_museum_objects,
    :colors,
    :main_path,
    :inv_number,
    :inv_extension,
    :inv_numberdoa,
    :amount,
    :finding_context,
    :finding_remarks,
    :description_authenticities_name,
    :description_conservation,
    :description_preservation_state_name,
    :acquisition_deliverer_name,
    :termlist_acquisition_delivered_by_id,
    :termlist_acquisition_kind_id,
    :is_finished,
    :inscription_decoration,
    :inscription_text,
    :inscription_translation,
    :termlist_authenticity_id,
    :priority_determined_by,
    :max_length,
    :max_width,
    :height,
    :opening_dm,
    :bottom_dm,
    :weight_in_gram,
    :remarks,
    :literature,
    :termlist_dating_millennium_id,
    :termlist_kind_of_object_id,
    :termlist_kind_of_object_specified_id,
    :termlist_decoration_id,
    :termlist_decoration_color_id,
    :termlist_inscription_letter_id,
    :termlist_inscription_language_id,
    :termlist_decoration_technique_id,
    :termlist_preservation_material_id,
    :termlist_preservation_object_id,
    :acquisition_document_number,
    :name_mega_jordan,
    :name_expedition,
    :site_number_mega,
    :site_number_jadis,
    :site_number_expedition,
    :coordinates_mega,
    :termlist_production_technique_id,
    :termlist_dating_period_id,
    :termlist_excavation_site_kind_id,
    :dating_timespan_begin,
    :dating_timespan_end,
    :images,
    :is_used,
    :current_build_step,
    :acquisition_date_precision,
    :coordinates_mega_long,
    :coordinates_mega_lat,
    :munsell_color,
    :needs_cleaning,
    :needs_conservation,
    :is_dating_timespan_begin_BC,
    :is_dating_timespan_end_BC,
    :main_material_specified_id,
    :termlist_material_specified_id,
    :termlist_priority_id,
    :acquisition_year,
    :acquisition_month,
    :acquisition_day,
    :kind_of_object_id,
    :main_path_id,
    :dating_millennium_begin_id,
    :dating_millennium_end_id,
    :is_dating_millennium_begin_bc,
    :is_dating_millennium_end_bc,
    :is_dating_century_begin_bc,
    :is_dating_century_end_bc,
    :is_dating_period_unknown,
    :is_dating_millennium_unknown,
    :is_dating_century_unknown,
    :is_dating_timespan_unknown,
    :dating_century_begin_id,
    :dating_century_end_id,
  ].freeze

  # Overwrite this method to customize how museum objects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(museum_object)
  #   "MuseumObject ##{museum_object.id}"
  # end
end
