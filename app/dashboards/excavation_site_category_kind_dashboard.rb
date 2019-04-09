require "administrate/base_dashboard"

class ExcavationSiteCategoryKindDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    excavation_site_category: Field::BelongsTo.with_options(class_name: "Termlist"),
    excavation_site_kind: Field::BelongsTo.with_options(class_name: "Termlist"),
    id: Field::Number,
    excavation_site_category_id: Field::Number,
    excavation_site_kind_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :excavation_site_category,
    :excavation_site_kind,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :excavation_site_category,
    :excavation_site_kind,
    :id,
    :excavation_site_category_id,
    :excavation_site_kind_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :excavation_site_category,
    :excavation_site_kind,
    :excavation_site_category_id,
    :excavation_site_kind_id,
  ].freeze

  # Overwrite this method to customize how excavation site category kinds are displayed
  # across all pages of the admin dashboard.
  #
   def display_resource(excavation_site_category_kind)
     "Excavation Site Category Kind #{excavation_site_category_kind.name}"
   end
end
