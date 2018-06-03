require "administrate/base_dashboard"

class JoinMuseumObjectDatingCenturyDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    museum_object: Field::BelongsTo,
    termlist_dating_century: Field::BelongsTo,
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
    :museum_object,
    :termlist_dating_century,
    :id,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :museum_object,
    :termlist_dating_century,
    :id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :museum_object,
    :termlist_dating_century,
  ].freeze

  # Overwrite this method to customize how join museum object dating centuries are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(join_museum_object_dating_century)
  #   "JoinMuseumObjectDatingCentury ##{join_museum_object_dating_century.id}"
  # end
end
