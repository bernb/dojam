class TermlistKindOfObjectSpecified < ApplicationRecord
  belongs_to :termlist_kind_of_object, required: false
  has_many :museum_objects
  has_many :termlist_kind_of_object_specifieds_production_techniques
  has_many :termlist_production_techniques, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_production_techniques
  has_many :termlist_kind_of_object_specifieds_decorations
  has_many :termlist_decorations, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_decorations
  has_many :termlist_kind_of_object_specifieds_color
  has_many :termlist_colors, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_color
  has_many :termlist_kind_of_object_specifieds_decoration_color
  has_many :termlist_decoration_colors, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_decoration_color
  has_many :termlist_kind_of_object_specifieds_decoration_techniques
  has_many :termlist_decoration_techniques, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_decoration_techniques
  has_many :termlist_kind_of_object_specifieds_preservation_materials
  has_many :termlist_preservation_materials, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_preservation_materials
  has_many :termlist_kind_of_object_specifieds_preservation_objects
  has_many :termlist_preservation_objects, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_preservation_objects
  has_many :termlist_kind_of_object_specifieds_inscription_languages
  has_many :termlist_inscription_languages, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_inscription_languages
  has_many :termlist_kind_of_object_specifieds_inscription_letters
  has_many :termlist_inscription_letters, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_inscription_letters
  has_many :termlist_kind_of_object_specifieds_dating_periods
  has_many :termlist_dating_periods, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_dating_periods
  has_many :termlist_kind_of_object_specifieds_dating_millennia
  has_many :termlist_dating_millennia, -> { order(name: :asc) }, through: :termlist_kind_of_object_specifieds_dating_millennia
  has_many :termlist_kind_of_object_specifieds_dating_centuries
  has_many :termlist_dating_centuries, through: :termlist_kind_of_object_specifieds_dating_centuries
end
