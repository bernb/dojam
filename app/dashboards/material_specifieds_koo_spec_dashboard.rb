require "administrate/base_dashboard"

class MaterialSpecifiedsKooSpecDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    termlist_material_specified: Field::BelongsTo,
    termlist_kind_of_object_specified: Field::BelongsTo,
    termlist_materials: Field::HasMany,
    termlist_kind_of_objects: Field::HasMany,
    colors_ms_koo_specs: Field::HasMany,
    termlist_colors: Field::HasMany,
    prod_techs_ms_koo_specs: Field::HasMany,
    termlist_production_techniques: Field::HasMany,
    dating_centuries_ms_koo_specs: Field::HasMany,
    termlist_dating_centuries: Field::HasMany,
    dating_millennia_ms_koo_specs: Field::HasMany,
    termlist_dating_millennia: Field::HasMany,
    dating_periods_ms_koo_specs: Field::HasMany,
    termlist_dating_periods: Field::HasMany,
    decoration_colors_ms_koo_specs: Field::HasMany,
    termlist_decoration_colors: Field::HasMany,
    decorations_ms_koo_specs: Field::HasMany,
    termlist_decorations: Field::HasMany,
    decoration_techniques_ms_koo_specs: Field::HasMany,
    termlist_decoration_techniques: Field::HasMany,
    inscription_languages_ms_koo_specs: Field::HasMany,
    termlist_inscription_languages: Field::HasMany,
    inscription_letters_ms_koo_specs: Field::HasMany,
    termlist_inscription_letters: Field::HasMany,
    preservation_materials_ms_koo_specs: Field::HasMany,
    termlist_preservation_materials: Field::HasMany,
    preservation_objects_ms_koo_specs: Field::HasMany,
    termlist_preservation_objects: Field::HasMany,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :termlist_material_specified,
    :termlist_kind_of_object_specified,
    :termlist_materials,
    :termlist_kind_of_objects,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :termlist_material_specified,
    :termlist_kind_of_object_specified,
    :termlist_materials,
    :termlist_kind_of_objects,
    :colors_ms_koo_specs,
    :termlist_colors,
    :prod_techs_ms_koo_specs,
    :termlist_production_techniques,
    :dating_centuries_ms_koo_specs,
    :termlist_dating_centuries,
    :dating_millennia_ms_koo_specs,
    :termlist_dating_millennia,
    :dating_periods_ms_koo_specs,
    :termlist_dating_periods,
    :decoration_colors_ms_koo_specs,
    :termlist_decoration_colors,
    :decorations_ms_koo_specs,
    :termlist_decorations,
    :decoration_techniques_ms_koo_specs,
    :termlist_decoration_techniques,
    :inscription_languages_ms_koo_specs,
    :termlist_inscription_languages,
    :inscription_letters_ms_koo_specs,
    :termlist_inscription_letters,
    :preservation_materials_ms_koo_specs,
    :termlist_preservation_materials,
    :preservation_objects_ms_koo_specs,
    :termlist_preservation_objects,
    :id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :termlist_material_specified,
    :termlist_kind_of_object_specified,
    :termlist_materials,
    :termlist_kind_of_objects,
    :colors_ms_koo_specs,
    :termlist_colors,
    :prod_techs_ms_koo_specs,
    :termlist_production_techniques,
    :dating_centuries_ms_koo_specs,
    :termlist_dating_centuries,
    :dating_millennia_ms_koo_specs,
    :termlist_dating_millennia,
    :dating_periods_ms_koo_specs,
    :termlist_dating_periods,
    :decoration_colors_ms_koo_specs,
    :termlist_decoration_colors,
    :decorations_ms_koo_specs,
    :termlist_decorations,
    :decoration_techniques_ms_koo_specs,
    :termlist_decoration_techniques,
    :inscription_languages_ms_koo_specs,
    :termlist_inscription_languages,
    :inscription_letters_ms_koo_specs,
    :termlist_inscription_letters,
    :preservation_materials_ms_koo_specs,
    :termlist_preservation_materials,
    :preservation_objects_ms_koo_specs,
    :termlist_preservation_objects,
  ].freeze

  # Overwrite this method to customize how material specifieds koo specs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(material_specifieds_koo_spec)
  #   "MaterialSpecifiedsKooSpec ##{material_specifieds_koo_spec.id}"
  # end
end
