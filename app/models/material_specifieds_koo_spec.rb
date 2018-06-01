class MaterialSpecifiedsKooSpec < ApplicationRecord
  belongs_to :termlist_material_specified
  belongs_to :termlist_kind_of_object_specified

	has_many :colors_ms_koo_specs
	has_many :termlist_colors, through: :colors_ms_koo_specs

	has_many :prod_techs_ms_koo_specs
	has_many :termlist_production_techniques, through: :prod_techs_ms_koo_specs

	has_many :dating_centuries_ms_koo_specs
	has_many :termlist_dating_centuries, through: :dating_centuries_ms_koo_specs

	has_many :decoration_colors_ms_koo_specs
	has_many :termlist_decoration_colors, through: :decoration_colors_ms_koo_specs

	has_many :decorations_ms_koo_specs
	has_many :termlist_decorations, through: :decorations_ms_koo_specs

	has_many :decoration_techniques_ms_koo_specs
	has_many :termlist_decoration_techniques, through: :decoration_techniques_ms_koo_specs

	has_many :inscription_languages_ms_koo_specs
	has_many :termlist_inscription_languages, through: :inscription_languages_ms_koo_specs
	has_many :inscription_letters_ms_koo_specs
	has_many :termlist_inscription_letters, through: :inscription_letters_ms_koo_specs

	has_many :preservation_materials_ms_koo_specs
	has_many :termlist_preservation_materials, through: :preservation_materials_ms_koo_specs

	has_many :preservation_materials_ms_koo_specs
	has_many :termlist_preservation_materials, through: :preservation_materials_ms_koo_specs

	has_many :preservation_objects_ms_koo_specs
	has_many :termlist_preservation_objects, through: :preservation_objects_ms_koo_specs
end
