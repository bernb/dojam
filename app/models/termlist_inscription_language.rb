class TermlistInscriptionLanguage < ApplicationRecord
  has_many :museum_objects
	has_many :inscription_languages_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :inscription_languages_ms_koo_specs
	include PropsAssociations
  include AddToAllOnCreate
end
