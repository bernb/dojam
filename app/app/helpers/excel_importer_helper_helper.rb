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
		@@attributes[:excavation_site_category_id] = "kind of site"
		@@attributes[:finding_context] = "finding context specified"
		@@attributes[:finding_remarks] = "remarks provenance"

		@@attributes[:main_material] = "primary material"
		@@attributes[:secondary_material] = "secondary material"
		@@attributes[:main_material_specified] = "material specified"
		@@attributes[:kind_of_object] = "kind of object"
		@@attributes[:kind_of_object_specified] = "kind of object specified"

		@@attributes[:production_technique_id] = "production technique"
		@@attributes[:colors] = "color"
		@@attributes[:munsell_color] = "Munsell color"
		@@attributes[:decoration_style_id] = "decoration style"
		@@attributes[:decoration_technique_id] = "decoration technique"
		@@attributes[:decoration_color_id] = "decoration color"
		@@attributes[:inscription_letter_id] = "scripts(s)"
		@@attributes[:inscription_language_id] = "language of inscription"
		@@attributes[:inscription_text] = "text of inscription"
		@@attributes[:inscription_translation] = "translation of inscription"

		@@attributes[:max_length] = "max. length"
		@@attributes[:max_width] = "max. width"
		@@attributes[:height] = "height"
		@@attributes[:opening_dm] = "opening dm"
		@@attributes[:bottom_dm] = "bottom dm"
		@@attributes[:weight_in_gram] = "weight in gram"
		@@attributes[:thickness] = "thickness"
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

		@@attributes[:remarks] = "description"
		@@attributes[:literature] = "literature"

	def set_museum_properties object, row
		object.storage_location = StorageLocation.find_by name_en: row[:storage_location]
		if object.storage_location.blank?
			add_termlist_not_found_error object: object, value: row[:storage_location], termlist_name: "StorageLocation"
			return
		end
		object.inv_number = row[:inv_number]
		object.inv_extension = row[:inv_extension]
		object.amount = row[:amount]
	end

	def add_termlist_not_found_error object:, value:, termlist_name:, with_path: false
		if with_path == false
			object.errors[:base] << "Could not find \"#{value}\" in #{termlist_name}"
		else
			object.errors[:base] << "Could not find \"#{value}\" as valid #{termlist_name} value for #{object.main_path.named_path}"
		end
	end

	def split_entry value
		if value.blank?
			return nil
		end
		value_array = value.split(',')
		value_array.each(&:strip!)
	end

	def resolve_range_entries value
		if value.blank?
			return
		end
		if value.include?("-")
			split_value = value.split("-")
			# If entry does not contain exactly one dash, something went wrong
			if split_value.size != 2
				return
			end
			range_begin = split_value[0]
			range_end = split_value[1]
			# If range_begin contains AD or BC we assume a correct termlist name
		  # Otherwise we determine a short hand version like '5th' and determine
			# BC/AD from range_end
			if range_begin.include?("BC") || range_begin.include?("AD")
			elsif range_end.include?("BC")
				range_begin = range_begin + "%BC"
			elsif range_end.include?("AD")
				range_begin = range_begin + "%AD"
			end
		else # value not include "-"
			range_begin = value
			range_end = value
		end
		return range_begin, range_end
	end

	def set_timespan_data object:, begin_value:, end_value: 
		timespan_begin = nil
		timespan_end = nil
		object.is_dating_timespan_unknown = true

		if end_value.present?
			timespan_begin = begin_value
			timespan_end = end_value
		else
			timespan_begin, timespan_end = resolve_range_entries begin_value
		end

		if timespan_begin.blank? || timespan_end.blank?
			return
		end

		if timespan_begin.include?("BC")
			object.is_dating_timespan_begin_BC = true
		elsif timespan_begin.include?("AD")
			object.is_dating_timespan_begin_BC = false
		else
			object.errors[:base] << "Malformed timespan information"
			return
		end

		if timespan_end.include?("BC")
			object.is_dating_timespan_end_BC = true
		elsif timespan_end.include?("AD")
			object.is_dating_timespan_end_BC = false
		else
			object.errors[:base] << "Malformed timespan information"
			return
		end

		timespan_begin = timespan_begin.split(" ")[0]
		timespan_end = timespan_end.split(" ")[0]
		if timespan_begin.match(/\A\d+\z/).blank? || timespan_end.match(/\A\d+\z/).blank?
			object.errors[:base] << "Malformed timespan information"
			return
		end
		object.is_dating_timespan_unknown = false
		object.dating_timespan_begin = Date.new timespan_begin.to_i
		object.dating_timespan_end = Date.new timespan_end.to_i
	end

	def set_century_data object:, value: 
		object.is_dating_century_unknown = true
		cent_begin, cent_end = resolve_range_entries value
		cent_begin_term = DatingCentury.where("name LIKE ?", cent_begin).first
		cent_end_term = DatingCentury.where("name LIKE ?", cent_end).first

		if cent_begin_term.blank?
			add_termlist_not_found_error object: object, value: cent_begin, termlist_name: "DatingCentury"
		elsif cent_end_term.blank?
			add_termlist_not_found_error object: object, value: cent_end, termlist_name: "DatingCentury"
		else
			object.dating_century_begin = cent_begin_term
			object.dating_century_end = cent_end_term
			object.is_dating_century_unknown = false
		end
	end

	def set_millennium_data object:, value: 
		object.is_dating_millennium_unknown = true
		mil_begin, mil_end = resolve_range_entries value
		mil_begin_term = DatingMillennium.where("name LIKE ?", mil_begin).first
		mil_end_term = DatingMillennium.where("name LIKE ?", mil_end).first

		if mil_begin_term.blank?
			add_termlist_not_found_error object: object, value: mil_begin, termlist_name:"DatingMillenniun"

		elsif mil_end_term.blank?
			add_termlist_not_found_error object: object, value: mil_end, termlist_name: "DatingMillenniun"
		else
			object.is_dating_millennium_unknown = false
			object.dating_millennium_begin = mil_begin_term
			object.dating_millennium_end = mil_end_term
		end
	end

	def set_main_path object, row
		material, material_specified, kind_of_object, kind_of_object_specified = assign_material_related_termlists row

		if material.blank?
			add_termlist_not_found_error object: object, value: row[:main_material], termlist_name: "Material"
			return
		end
		if material_specified.blank?
			add_termlist_not_found_error object: object, value: row[:main_material_specified], termlist_name: "MaterialSpecified"
			return
		end
		if kind_of_object.blank?
			add_termlist_not_found_error object: object, value: row[:kind_of_object], termlist_name: "KindOfObject"
			return
		end
		if kind_of_object_specified.blank?
			add_termlist_not_found_error object: object, value: row[:kind_of_object_specified], termlist_name: "KindOfObjectSpecified"
			return
		end

		path_name = "/" + material.id.to_s + "/" + material_specified.id.to_s + "/" + kind_of_object.id.to_s + "/" + kind_of_object_specified.id.to_s
		path = Path.find_by path: path_name
		if path.blank?
			object.errors[:base] << "Material / kind of object combination not found."
			return
		end

		object.main_path = path
	end


	def search_for_possible_props object, termlist_class, termlist_value
		valid_terms = object.get_possible_props_for(termlist_class.to_s)
		found_term = valid_terms.find_by(name_en: termlist_value.to_s)
		return found_term
	end

	def set_color object:, values:
		colors = []
		values.each do |color_name|
			color = search_for_possible_props object, Color, color_name
			if color.blank?
				add_termlist_not_found_error object: object, value: color_name, termlist_name: "Color", with_path: true
				next
			end
			object.colors << color
		end
	end

	def set_association object:, column:, termlist_value:, current_line:, with_path: true
		i = current_line
		termlist = column.to_s
		termlist.slice!("_id")
		if termlist == "decoration_style"
			termlist = "decoration"
		end
		termlist_class = termlist.camelcase.constantize

		found_termlist = search_for_possible_props object, termlist_class, termlist_value

		if found_termlist.present?
			if termlist == "decoration"
				termlist = "decoration_style"
			end
			object.send(termlist + "=", found_termlist)
		else
			add_termlist_not_found_error object: object, value: termlist_value, termlist_name: termlist_class.to_s, with_path: with_path
		end
	end

	def assign_material_related_termlists row, current_line = nil
		if row[:main_material].blank? || row[:main_material_specified].blank? || row[:kind_of_object].blank? || row[:kind_of_object].blank? || row[:kind_of_object_specified].blank?
			return false
		end

		material = Material.find_by name_en: row[:main_material]
		if row[:main_material_specified].include?(',')
			ms_string = split_entry(row[:main_material_specified])[0]
		else
			ms_string = row[:main_material_specified]
		end
		material_specified = MaterialSpecified.find_by name_en: ms_string
		kind_of_object = KindOfObject.find_by name_en: row[:kind_of_object]
		kind_of_object_specified = KindOfObjectSpecified.find_by name_en: row[:kind_of_object_specified]
		return material, material_specified, kind_of_object, kind_of_object_specified
	end

	def is_correct_format key, value
		# Does not work as intended right now as
		# roo converts number-like values into ruby Fixnum, 
		# need a way to get unformatted value with current approach
		return true
		number_array = [
			:max_length,
			:max_width,
			:height,
			:opening_dm,
			:bottom_dm,
			:weight_in_gram
		]
		if number_array.include?(key)
			return /^(\d{1,3}\.\d{1,2}|\d{1,3})$/.match? value
		end
		return true
	end

	def is_simple_attribute key
		!is_complex_attribute(key) && !is_regular_termlist(key)
	end

	def is_regular_termlist key
		key.to_s.ends_with?("_id") && !is_complex_attribute(key)
	end

	def is_complex_attribute key
		array = [:needs_cleaning, :needs_conservation, :storage_location, :excavation_site, :colors, :production_technique_id, :decoration_color_id, :decoration_technique_id]
			array.include?(key) ||
			key.to_s.include?("kind_of") ||
			key.to_s.include?("main_material") ||
			key.to_s.include?("secondary_material") ||
			key.to_s.include?("dating") ||
			key.to_s.include?("storage")
	end

	def build_sherdname row
		sherdname = row[:inv_number].to_s
		if row[:inv_extension].present?
		 sherdname = sherdname + "-" + row[:inv_extension].to_s 
		end
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
