require "administrate/base_dashboard"

class PathDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    termlist_paths: Field::HasMany,
    termlists: Field::HasMany,
    museum_object_paths: Field::HasMany,
    museum_objects: Field::HasMany,
    id: Field::Number,
    path: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :termlist_paths,
    :termlists,
    :museum_object_paths,
    :museum_objects,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :termlist_paths,
    :termlists,
    :museum_object_paths,
    :museum_objects,
    :id,
    :path,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :termlist_paths,
    :termlists,
    :museum_object_paths,
    :museum_objects,
    :path,
  ].freeze

  # Overwrite this method to customize how paths are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(path)
  #   "Path ##{path.id}"
  # end
end
