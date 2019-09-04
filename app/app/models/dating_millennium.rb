class DatingMillennium < Termlist
  has_many :museum_objects_as_begin, foreign_key: 'dating_millennium_begin', class_name: 'MuseumObject'
  has_many :museum_objects_as_end, foreign_key: 'dating_millennium_end', class_name: 'MuseumObject'
	acts_as_list scope: [:type]

  def museum_objects
    museum_objects_as_begin.or(museum_objects_as_end)
  end

	def self.is_independent_of_paths
		true
	end
end
