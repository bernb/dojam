class TermlistKindOfObject < ApplicationRecord
	alias_attribute :props, :material_specifieds_koo_specs
  has_many :museum_objects
	has_many :termlist_kind_of_object_specifieds, -> (me) {where.not(name: me.name)}
	# all_koos only used for easier asscociation navigation
	# So at the end of class it is declared private
	has_many :all_koos, class_name: "TermlistKindOfObjectSpecified"
	has_many :material_specifieds_koo_specs, through: :all_koos
	has_many :termlist_material_specifieds, ->{distinct}, through: :material_specifieds_koo_specs
	has_many :termlist_materials, ->{distinct}, through: :termlist_material_specifieds
	

#	def termlist_material_specifieds
#		TermlistMaterialSpecified.joins(:termlist_kind_of_object_specifieds).where(termlist_kind_of_object_specifieds: {termlist_kind_of_object: self})
#	end
	private :all_koos
end
