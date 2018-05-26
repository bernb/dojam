class MaterialSpecifiedsKooSpec < ApplicationRecord
  belongs_to :termlist_material_specified
  belongs_to :termlist_kind_of_object_specified
	has_many :colors_ms_koo_specs
	has_many :termlist_colors, through: :colors_ms_koo_specs
end
