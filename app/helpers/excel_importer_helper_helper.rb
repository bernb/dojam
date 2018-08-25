module ExcelImporterHelperHelper

		@@attributes = {}
		@@attributes[:storage_general_location] = "storage location"
		@@attributes[:storage_location_id] = "detailed location"
		@@attributes[:inv_number] = "inventory number" 
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
		@@attributes[:materials] = "secondary material"
		@@attributes[:main_material_specified] = "material specified"
		@@attributes[:kind_of_object] = "kind of object"
		@@attributes[:kind_of_object_specified] = "kind of object specified"

		@@attributes[:production_technique_id] = "production technique"
		@@attributes[:colors] = "color"
		@@attributes[:munsell_color] = "Munsell color"
		@@attributes[:decoration_style_id] = "decoration style"
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


	def search_for_possible_props object, termlist_class, termlist_value
		# As of writing this, get_possible_props returns an array instead of a relation
		# because of ordering problems, so we need to retrieve the correct element this way
		found_termlist = object.get_possible_props_for(termlist_class.to_s)
		index = found_termlist&.index{|t| t.name == termlist_value}
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
			return
		end

		# Find out if the term actual exists
		# and add the corresponding path if a match is found
		found_termlist = termlist_class.find_by(name: termlist_value)
		if found_termlist.present? # If we found one in the more general query
			# We check for existing paths as we have termlists that allow any path
			# which is not yet explicitly implemented
			if found_termlist.paths.present? 
				logger.tagged("Row #{i.to_s}"){logger.warn "#{termlist_value} is not a valid termlist value for #{object.main_path.named_path}"}
				logger.tagged("Row #{i.to_s}"){logger.warn "Adding #{termlist_value} now for #{object.main_path.named_path}"}
				found_termlist.paths << object.main_path
			else
				logger.tagged("Row #{i.to_s}"){logger.debug "Setting #{termlist_class.to_s} to #{termlist_value}"}
			end # if has paths
			object.send(termlist + "=", found_termlist)
		end # if termlist name found in Database

	end

	def assign_material_related_termlists row, current_line
		i = current_line
		logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
		if row[:material].blank?
			logger.tagged("Row #{i.to_s}"){logger.error "No material given. Skipping this row..."}
			return
		end

		if row[:material_specified].blank?
			logger.tagged("Row #{i.to_s}"){logger.error "No material specified given. Skipping this row..."}
			return
		end

		if row[:kind_of_object].blank?
			logger.tagged("Row #{i.to_s}"){logger.error "No kind of object given. Skipping this row..."}
			return
		end

		if row[:kind_of_object_specified].blank?
			logger.tagged("Row #{i.to_s}"){logger.error "No kind of object specified given. Skipping this row..."}
			return
		end

		material = Material.find_by name: row[:material]
		material_specified = MaterialSpecified.find_by name: row[:material_specified]
		kind_of_object = KindOfObject.find_by name: row[:kind_of_object]
		kind_of_object_specified = KindOfObjectSpecified.find_by name: row[:kind_of_object_specified]
		if material.blank? 
			logger.tagged("Row #{i.to_s}"){logger.error "Unknown material #{row[:material]}. Skipping this row..."}
		end
		if material_specified.blank? 
			logger.tagged("Row #{i.to_s}"){logger.error "Unknown material specified #{row[:material_specified]}. Skipping this row..."}
		end
		if kind_of_object.blank? 
			logger.tagged("Row #{i.to_s}"){logger.error "Unknown kind of object #{row[:kind_of_object]}. Skipping this row..."}
		end
		if kind_of_object_specified.blank? 
			logger.tagged("Row #{i.to_s}"){logger.error "Unknown kind of object specified #{row[:kind_of_object_specified]}. Skipping this row..."}
		end
		return material, material_specified, kind_of_object, kind_of_object_specified
	end


	def is_simple_attribute key
		MuseumObject.method_defined?(key) && !key.to_s.ends_with?("_id") && @@atomic_attributes.include?(key)
	end

	def is_regular_termlist key
		!is_complex_termlist key
	end

	def is_complex_termlist key
		array = [:needs_cleaning, :needs_conservation, :storage_location, :excavation_site]
		MuseumObject.method_defined?(key) && (
			array.include?(key.to_s) ||
			key.to_s.include?("kind_of") ||
			key.to_s.include?("material") ||
			key.to_s.include?("dating") ||
			key.to_s.include?("path") ||
			key.to_s.include?("dummy") ||
			key.to_s.include?("storage") ||
			key.to_s.starts_with?("dating") ||
			!key.to_s.ends_with?("_id")
		)
	end

	def build_sherdname row
		sherdname = row[:inv_number].to_s
		sherdname + "-" + row[:inv_extension].to_s unless row[:inv_extension].blank?
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
