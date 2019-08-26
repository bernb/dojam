class DecorationColor < Termlist
  has_many :decoration_color_museum_objects
  has_many :museum_objects, through: :decoration_color_museum_objects
end
