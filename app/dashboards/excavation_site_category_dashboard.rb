require "administrate/base_dashboard"

class ExcavationSiteCategoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    termlist_paths: Field::HasMany,
    paths: Field::HasMany,
    excavation_site_category_kinds: Field::HasMany,
    excavation_site_kinds: Field::HasMany.with_options(class_name: "Termlist"),
    id: Field::Number,
    type: Field::String,
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
    :id,
    :name,
    :excavation_site_kinds
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :excavation_site_kinds,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :excavation_site_kinds,
  ].freeze

  # Overwrite this method to customize how excavation site categories are displayed
  # across all pages of the admin dashboard.
  #
   def display_resource(excavation_site_category)
     "Excavation Site Category #{excavation_site_category.name}"
   end
end
