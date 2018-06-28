require "administrate/base_dashboard"

class TermlistMaterialSpecifiedDashboard < Administrate::BaseDashboard

	def display_resource(resource)
		resource.name	
	end

  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    termlist_material: Field::BelongsTo,
    join_museum_object_material_specifieds: Field::HasMany,
    museum_objects: Field::HasMany,
    material_specifieds_koo_specs: Field::HasMany,
    termlist_kind_of_object_specifieds: Field::HasMany,
    termlist_kind_of_objects: Field::HasMany,
    prod_techs_ms_koo_specs: Field::HasMany,
    termlist_production_techniques: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
		:name,
		:termlist_material,
    :museum_objects,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :termlist_material,
    :museum_objects,
    :termlist_kind_of_object_specifieds,
    :termlist_kind_of_objects,
    :termlist_production_techniques,
    :id,
    :name,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :termlist_material,
    :museum_objects,
    :termlist_kind_of_object_specifieds,
    :termlist_kind_of_objects,
    :termlist_production_techniques,
    :name,
  ].freeze

  # Overwrite this method to customize how termlist material specifieds are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(termlist_material_specified)
  #   "TermlistMaterialSpecified ##{termlist_material_specified.id}"
  # end
end