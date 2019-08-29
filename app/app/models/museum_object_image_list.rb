class MuseumObjectImageList < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :museum_object
  has_many_attached :list
  has_one_attached :main
  has_one_attached :main_r
  after_validation :purge_main_r

  # Not working
  def purge_main_r
    main_r.purge
  end

  def main_for_render
    if main_r.attachment.nil?
      rerender_main
    end
    return main_r
  end

  def rerender_main
    original_image_path = ActiveStorage::Blob.service.path_for main.key
    converted_image = MiniMagick::Image.open original_image_path 
    converted_image.format "png"
    main_r.attach(io: File.open(converted_image.tempfile),
                  filename: main.blob.filename.base + ".png",
                  content_type: "image/png")
  end
end
