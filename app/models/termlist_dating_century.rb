class TermlistDatingCentury < ApplicationRecord
  acts_as_list
  has_many :join_museum_object_dating_centuries
  has_many :museum_objects, through: :join_museum_object_dating_centuries
  has_many :dating_centuries_ms_koo_specs
  has_many :material_specifieds_koo_specs, through: :dating_centuries_ms_koo_specs
	include PropsAssociations
  include AddToAllOnCreate
  default_scope { order(position: :asc) }
end
