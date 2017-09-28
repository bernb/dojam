class JoinTableMuseumObjectTermlistMaterial < ApplicationRecord
  belongs_to :museum_object
  belongs_to :termlist_material
end
