class TermlistKindOfObject < ApplicationRecord
  belongs_to :termlist_material_specified, required: false
end
