class TermlistInscriptionLetter < ApplicationRecord
  has_many :museum_objects
	has_many :inscription_letters_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :inscription_letters_ms_koo_specs
	include PropsAssociations
end
