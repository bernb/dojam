require "administrate/base_dashboard"

class TermlistKindOfObjectDashboard < Administrate::BaseDashboard

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
    museum_objects: Field::HasMany,
    termlist_kind_of_object_specifieds: Field::HasMany,
    all_koos: Field::HasMany.with_options(class_name: "TermlistKindOfObjectSpecified"),
    material_specifieds_koo_specs: Field::HasMany,
    termlist_material_specifieds: Field::HasMany,
    termlist_materials: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    termlist_material_specified_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
		:id,
		:name,
    :museum_objects,
		:termlist_material_specifieds
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
		:termlist_kind_of_object_specifieds,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
  ].freeze

  # Overwrite this method to customize how termlist kind of objects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(termlist_kind_of_object)
  #   "TermlistKindOfObject ##{termlist_kind_of_object.id}"
  # end
end
