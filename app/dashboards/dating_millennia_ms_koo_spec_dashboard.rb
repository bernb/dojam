require "administrate/base_dashboard"

class DatingMillenniaMsKooSpecDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    termlist_dating_millennium: Field::BelongsTo,
    material_specifieds_koo_spec: Field::BelongsTo,
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
    :termlist_dating_millennium,
    :material_specifieds_koo_spec,
    :id,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :termlist_dating_millennium,
    :material_specifieds_koo_spec,
    :id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :termlist_dating_millennium,
    :material_specifieds_koo_spec,
  ].freeze

  # Overwrite this method to customize how dating millennia ms koo specs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(dating_millennia_ms_koo_spec)
  #   "DatingMillenniaMsKooSpec ##{dating_millennia_ms_koo_spec.id}"
  # end
end