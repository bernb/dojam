require "administrate/base_dashboard"

class MuseumObjectImageListDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    museum_object: Field::BelongsTo,
    list_attachments: Field::HasMany.with_options(class_name: "ActiveStorage::Attachment"),
    list_blobs: Field::HasMany.with_options(class_name: "ActiveStorage::Blob"),
    main_attachment: Field::HasOne,
    main_blob: Field::HasOne,
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
    :list_attachments,
    :list_blobs,
    :main_attachment,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :museum_object,
    :list_attachments,
    :list_blobs,
    :main_attachment,
    :main_blob,
    :id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :museum_object,
    :list_attachments,
    :list_blobs,
    :main_attachment,
    :main_blob,
  ].freeze

  # Overwrite this method to customize how museum object image lists are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(museum_object_image_list)
  #   "MuseumObjectImageList ##{museum_object_image_list.id}"
  # end
end
