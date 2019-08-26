class Color < Termlist
  has_many :color_museum_objects
  has_many :museum_objects, through: :color_museum_objects
end
