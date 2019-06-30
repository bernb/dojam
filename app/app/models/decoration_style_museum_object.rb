class DecorationStyleMuseumObject < ApplicationRecord
  belongs_to :decoration_style, class_name: "Decoration"
  belongs_to :museum_object
end
