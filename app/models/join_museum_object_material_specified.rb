class JoinMuseumObjectMaterialSpecified < ApplicationRecord
  belongs_to :museum_object
  belongs_to :termlist_material_specified
end
