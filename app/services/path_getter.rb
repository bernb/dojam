class PathGetter
	def self.call(material: nil, material_specified: nil, kind_of_object: nil, kind_of_object_specified: nil)
		if material.present?
			path = "/" + material.id.to_s
			if material_specified.present?
				path = path + "/" + material_specified.id.to_s
				if kind_of_object.present?
					path = path + "/" + kind_of_object.id.to_s
					if kind_of_object_specified.present?
						path = path + "/" + kind_of_object_specified.id.to_s
					end
				end
			end
		end
		return path
	end

end
