class TermlistInscriptionLanguage < ApplicationRecord
  belongs_to :termlist_material_specified
  has_many :museum_objects
end
