require "administrate/base_dashboard"

class ColorMuseumObjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    color: Field::BelongsTo,
    museum_object: Field::BelongsTo,
    id: Field::Number,
    termlist_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :color,
    :museum_object,
    :id,
    :termlist_id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :color,
    :museum_object,
    :id,
    :termlist_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :color,
    :museum_object,
    :termlist_id,
  ].freeze

  # Overwrite this method to customize how color museum objects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(color_museum_object)
  #   "ColorMuseumObject ##{color_museum_object.id}"
  # end
end
