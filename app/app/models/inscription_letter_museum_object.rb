class InscriptionLetterMuseumObject < ApplicationRecord
  belongs_to :inscription_letter
  belongs_to :museum_object
end
