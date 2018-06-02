class TermlistDatingMillennium < ApplicationRecord
  acts_as_list 
  has_many :museum_objects
  default_scope { order(position: :asc) }
	has_many :dating_millennia_ms_koo_specs
	has_many :material_specifieds_koo_specs, through: :dating_millennia_ms_koo_specs
end
