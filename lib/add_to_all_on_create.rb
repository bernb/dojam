module AddToAllOnCreate
	extend ActiveSupport::Concern
	included do
		before_create :add_to_all
	end

	private
	def add_to_all
		self.material_specifieds_koo_specs << MaterialSpecifiedsKooSpec.all
	end
end
