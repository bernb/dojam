class TermlistDecorationTechnique < ApplicationRecord
  has_many :museum_objects
	has_many :decoration_techniques_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :decoration_techniques_ms_koo_specs
	include PropsAssociations
  include AddToAllOnCreate
end
