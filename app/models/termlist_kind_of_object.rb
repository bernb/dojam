class TermlistKindOfObject < ApplicationRecord
  has_many :museum_objects
	has_many :termlist_kind_of_object_specifieds, -> (me) {where.not(name: me.name)}

	def termlist_material_specifieds
		TermlistMaterialSpecified.joins(:termlist_kind_of_object_specifieds).where(termlist_kind_of_object_specifieds: {termlist_kind_of_object: self})
	end
end
