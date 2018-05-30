module PropsAssociations
	extend ActiveSupport::Concern
	included do
		has_many :termlist_kind_of_object_specifieds, through: :material_specifieds_koo_specs
	end
end
