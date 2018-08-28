module ExcelImporterHelperHelper

		@@attributes = {}
		@@attributes[:storage_general_location] = "storage location"
		@@attributes[:storage_location] = "detailed location"
		@@attributes[:inv_number] = "inventory number of museum"
		@@attributes[:inv_extension] = "extension of inventory number"
		@@attributes[:inv_numberdoa] = "other inventory number"
		@@attributes[:amount] = "number of objects"
		@@attributes[:acquisition_kind_id] = "kind of acquisition"
		@@attributes[:acquisition_delivered_by_id] = "delivered by"
		@@attributes[:acquisition_deliverer_name] = "name of deliverer"
		@@attributes[:acquisition_year] = "date of acquisition year"
		@@attributes[:acquisition_month] = "date of acquisition month"
		@@attributes[:acquisition_day] = "date of acquisition day"
		@@attributes[:acquisition_document_number] = "no. of acquisition document"
		@@attributes[:remarks_acquisition] = "remarks acquisition"
		@@attributes[:excavation_site_id] = "site name"
		@@attributes[:name_expedition] = "other site name(s)"
		@@attributes[:site_number_mega] = "site number according to MEGA"
		@@attributes[:site_number_jadis] = "site number according to JADIS"
		@@attributes[:site_number_expedition] = "site number according to expedition"
		@@attributes[:coordinates_mega_long] = "Long = E"
		@@attributes[:coordinates_mega_lat] = "Lat = N"
		@@attributes[:excavation_site_kind_id] = "kind of site specified"
		@@attributes[:finding_context] = "finding context specified"
		@@attributes[:finding_remarks] = "remarks provenance"

		@@attributes[:main_material] = "primary material"
		@@attributes[:main_materials] = "secondary material"
		@@attributes[:main_material_specified] = "material specified"
		@@attributes[:kind_of_object] = "kind of object"
		@@attributes[:kind_of_object_specified] = "kind of object specified"

		@@attributes[:production_technique_id] = "production technique"
		@@attributes[:colors] = "color"
		@@attributes[:munsell_color] = "Munsell color"
		@@attributes[:decoration] = "decoration style"
		@@attributes[:decoration_technique_id] = "decoration technique"
		@@attributes[:decoration_color_id] = "decoration color"
		@@attributes[:inscription_letter_id] = "letters of inscription"
		@@attributes[:inscription_language_id] = "language of inscription"
		@@attributes[:inscription_text] = "text of inscription"
		@@attributes[:inscription_translation] = "translation of inscription"

		@@attributes[:max_length] = "max. length"
		@@attributes[:max_width] = "max. width"
		@@attributes[:height] = "height"
		@@attributes[:opening_dm] = "opening dm"
		@@attributes[:bottom_dm] = "bottom dm"
		@@attributes[:weight_in_gram] = "weight in gram"
		@@attributes[:preservation_material_id] = "preservation of material"
		@@attributes[:preservation_object_id] = "preservation of object"
		@@attributes[:description_conservation] = "preservation/conservation remarks"
		@@attributes[:needs_conservation] = "conservation needed"
		@@attributes[:needs_cleaning] = "cleaning needed"
		@@attributes[:authenticity_id] = "authenticity"
		@@attributes[:priority_id] = "priority"
		@@attributes[:priority_determined_by] = "priority determined by"

		@@attributes[:dating_period] = "period"
		@@attributes[:dating_millennium] = "millennium"
		@@attributes[:dating_century] = "century"
		@@attributes[:dating_timespan_begin] = "timespan begin"
		@@attributes[:dating_timespan_end] = "timespan end"

		@@attributes[:description] = "description"
		@@attributes[:remarks] = "remarks"
		@@attributes[:literature] = "literature"

		# Those are not found in latest reference excel sheet
		@@attributes[:inscription_decoration] = nil
		@@attributes[:name_mega_jordan] = "site name according to MEGA"
		@@attributes[:name_expedition] = "site name"
		@@attributes[:inscription_decoration] = "decoration of inscription"

	def set_museum_properties object, row
		object.inv_number = row[:inv_number]
		object.inv_extension = row[:inv_extension]
		object.storage_location = StorageLocation.find_by name: row[:storage_location]
		object.storage_location.blank?
		object.errors[:base] << "Could not find storage location \"#{row[:storage_location]}\""
		object.amount = row[:amount]
		object.save
	end

	def set_main_path object, row
		material, material_specified, kind_of_object, kind_of_object_specified = assign_material_related_termlists row

		if material.blank?
			object.errors[:base] << "Could not find material \"#{row[:main_material]}\""
			return
		end
		if material_specified.blank?
			object.errors[:base] << "Could not find specified material \"#{row[:main_material_specified]}\""
			return
		end
		if kind_of_object.blank?
			object.errors[:base] << "Could not find kind of object \"#{row[:kind_of_object]}\""
			return
		end
		if kind_of_object_specified.blank?
			object.errors[:base] << "Could not find specified kind of object \"#{row[:kind_of_object_specified]}\""
			return
		end

		path = Path.find_by_material_related material, material_specified, kind_of_object, kind_of_object_specified
		if path.blank?
			object.errors[:base] << "Material / kind of object combination not found."
			return
		end

		object.main_path = path
	end


	def search_for_possible_props object, termlist_class, termlist_value
		# As of writing this, get_possible_props returns an array instead of a relation
		# because of ordering problems, so we need to retrieve the correct element this way
		found_termlist = object.get_possible_props_for(termlist_class.to_s)
		index = found_termlist&.index{|t| t.name == termlist_value.to_s}
		if index.present?
			found_termlist = found_termlist[index]
		else
			found_termlist = nil
		end
		return found_termlist
	end

	def set_association object:, column:, termlist_value:, current_line:
		i = current_line
		logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
		termlist = column.to_s
		termlist.slice!("_id")
		termlist_class = termlist.camelcase.constantize

		found_termlist = search_for_possible_props object, termlist_class, termlist_value

		if found_termlist.present?
			logger.tagged("Row #{i.to_s}"){logger.debug "Setting #{termlist_class.to_s} to #{termlist_value}"}
			object.send(termlist + "=", found_termlist)
		else
			logger.tagged("Row #{i.to_s}"){logger.warn "Could not find #{termlist_value} for #{termlist_class.to_s}"}
		end
	end

	def assign_material_related_termlists row, current_line = nil
		if row[:main_material].blank? || row[:main_material_specified].blank? || row[:kind_of_object].blank? || row[:kind_of_object].blank? || row[:kind_of_object_specified].blank?
			return false
		end

		material = Material.find_by name: row[:main_material]
		material_specified = MaterialSpecified.find_by name: row[:main_material_specified]
		kind_of_object = KindOfObject.find_by name: row[:kind_of_object]
		kind_of_object_specified = KindOfObjectSpecified.find_by name: row[:kind_of_object_specified]
		return material, material_specified, kind_of_object, kind_of_object_specified
	end


	def is_simple_attribute key
		MuseumObject.method_defined?(key.to_s+"=") &&	!is_complex_attribute(key)
	end

	def is_regular_termlist key
		MuseumObject.method_defined?(key.to_s+"=") && key.to_s.ends_with?("_id")
	end

	def is_complex_attribute key
		array = [:needs_cleaning, :needs_conservation, :storage_location, :excavation_site, :colors]
			key.to_s.ends_with?("_id") ||
			array.include?(key) ||
			key.to_s.include?("kind_of") ||
			key.to_s.include?("material") ||
			key.to_s.include?("dating") ||
			key.to_s.include?("storage")
	end

	def build_sherdname row
		sherdname = row[:inv_number].to_s
		sherdname + "-" + row[:inv_extension].to_s unless row[:inv_extension].blank?
		return sherdname
	end

	def set_boolean_for object, attribute, attr_value
		if attr_value == "yes" || attr_value == "Yes" || attr_value == "YES"
			value = true
		else
			value = false
		end
		object.send(attribute.to_s+"=", value)
	end


end
