class TermlistPreservationObject < ApplicationRecord
	default_scope{order(name: :asc)}
  has_many :museum_objects
	has_many :preservation_objects_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :preservation_objects_ms_koo_specs
	include PropsAssociations
  include AddToAllOnCreate
end
