class TermlistKindOfObjectSpecified < ApplicationRecord
  belongs_to :termlist_kind_of_object, required: false
  has_many :museum_objects
	has_many :material_specifieds_koo_specs
	has_many :termlist_material_specifieds, through: :material_specifieds_koo_specs

end
