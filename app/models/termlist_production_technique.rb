class TermlistProductionTechnique < ApplicationRecord
	has_many :prod_techs_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :prod_techs_ms_koo_specs
  has_many :museum_objects
	include PropsAssociations
end
