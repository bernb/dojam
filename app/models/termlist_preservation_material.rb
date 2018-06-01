class TermlistPreservationMaterial < ApplicationRecord
  has_many :museum_objects
	has_many :preservation_materials_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :preservation_materials_ms_koo_specs
	include PropsAssociations
end
