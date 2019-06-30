class InscriptionLanguageMuseumObject < ApplicationRecord
  belongs_to :inscription_language
  belongs_to :museum_object
end
