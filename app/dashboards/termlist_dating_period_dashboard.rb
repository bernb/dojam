require "administrate/base_dashboard"

class TermlistDatingPeriodDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    museum_objects: Field::HasMany,
    dating_periods_ms_koo_specs: Field::HasMany,
    material_specifieds_koo_specs: Field::HasMany,
    termlist_kind_of_object_specifieds: Field::HasMany,
    termlist_material_specifieds: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    position: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :museum_objects,
    :dating_periods_ms_koo_specs,
    :material_specifieds_koo_specs,
    :termlist_kind_of_object_specifieds,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :museum_objects,
    :dating_periods_ms_koo_specs,
    :material_specifieds_koo_specs,
    :termlist_kind_of_object_specifieds,
    :termlist_material_specifieds,
    :id,
    :name,
    :created_at,
    :updated_at,
    :position,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :museum_objects,
    :dating_periods_ms_koo_specs,
    :material_specifieds_koo_specs,
    :termlist_kind_of_object_specifieds,
    :termlist_material_specifieds,
    :name,
    :position,
  ].freeze

  # Overwrite this method to customize how termlist dating periods are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(termlist_dating_period)
  #   "TermlistDatingPeriod ##{termlist_dating_period.id}"
  # end
end
