class TermlistDecoration < ApplicationRecord
  has_many :museum_objects
  has_many :decorations_ms_koo_specs
  has_many :material_specifieds_koo_specs, through: :decorations_ms_koo_specs
	include PropsAssociations
end
