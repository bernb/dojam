module ExcelImporterHelper
	require 'roo'

	def import_excel_from_file file

		attributes = {}
		#		MuseumObject.columns.each do |column|
		#			attributes[column.name.to_sym] = nil
		#		end	

		attributes[:inv_number] = "inventory number of museum"
		attributes[:inv_extension] = "extension of inventory number"
		attributes[:inv_numberdoa] = "other inventory number"
		attributes[:amount] = "number of objects"
		attributes[:finding_context] = "finding context specified"
		attributes[:finding_remarks] = "remarks"
		attributes[:description_conservation] = "preservation/conservation remarks"
		attributes[:acquisition_deliverer_name] = "delivered by"
		attributes[:storage_location_id] = "storage location"
		attributes[:storage_general_location_dummy] = "detailed location"
		attributes[:excavation_site_id] = "site name"
		attributes[:inscription_decoration] = nil
		attributes[:inscription_text] = "text of inscription"
		attributes[:inscription_translation] = "translation of inscription"
		attributes[:priority_determined_by] = "priority determined by"
		attributes[:max_length] = "length"
		attributes[:max_width] = "width"
		attributes[:height] = "height"
		attributes[:opening_dm] = "opening dm"
		attributes[:bottom_dm] = "bottom dm"
		attributes[:weight_in_gram] = "weight in gram"
		attributes[:remarks] = "remarks"
		attributes[:literature] = "literature"
		attributes[:acquisition_document_number] = "number of acquisition document"
		attributes[:name_mega_jordan] = "site name according to MEGA"
		attributes[:name_expedition] = "site name"
		attributes[:site_number_mega] = "site number according to MEGA"
		attributes[:site_number_jadis] = "site number according to JADIS"
		attributes[:site_number_expedition] = "site number according to expedition"
		attributes[:dating_timespan_begin] = "timespan begin"
		attributes[:dating_timespan_end] = "timespan end"
		attributes[:acquisition_date_precision] = "date of acquisition"
		attributes[:coordinates_mega_long] = "Coordinates of site according to MEGA"
		attributes[:coordinates_mega_lat] = "Coordinates of site according to MEGA"
		attributes[:munsell_color] = "Munsell color"
		attributes[:needs_cleaning] = "cleaning needed"
		attributes[:needs_conservation] = "conservation needed"
		attributes[:is_dating_timespan_begin_BC] = "timespan begin"
		attributes[:is_dating_timespan_end_BC] = "timespan end"
		attributes[:main_material_specified_id] = "material specified"
		attributes[:acquisition_year] = "date of acquisition"
		attributes[:acquisition_month] = "date of acquisition"
		attributes[:acquisition_day] = "date of acquisition"
		attributes[:acquisition_kind_id] = "kind of acquisition"
		attributes[:acquisition_delivered_by_id] = "name of deliverer"
		attributes[:excavation_site_kind_id] = "kind of site"
		attributes[:kind_of_object_id] = "kind of object"
		attributes[:kind_of_object_specified_id] = "kind of object specified"
		attributes[:production_technique_id] = "production technique"
		attributes[:decoration_style_id] = "decoration style"
		attributes[:decoration_technique_id] = "decoration technique"
		attributes[:decoration_color_id] = "decoration color"
		attributes[:inscription_letter_id] = "letters of inscription"
		attributes[:inscription_language_id] = "language of inscription"
		attributes[:preservation_material_id] = "preservation of material"
		attributes[:preservation_object_id] = "preservation of object"
		attributes[:authenticity_id] = "authenticity"
		attributes[:priority_id] = "priority"
		attributes[:dating_period_id] = "period"
		attributes[:is_dating_period_unknown] = "period"
		attributes[:dating_millennium_begin_id] = "millennium"
		attributes[:dating_millennium_end_id] = "millennium"
		attributes[:is_dating_millennium_begin_bc] = "millennium"
		attributes[:is_dating_millennium_end_bc] = "millennium"
		attributes[:is_dating_millennium_unknown] = "millennium"
		attributes[:is_dating_century_begin_bc] = "century"
		attributes[:is_dating_century_end_bc] = "century"
		attributes[:is_dating_century_unknown] = "century"
		attributes[:dating_century_begin_id] = "century"
		attributes[:dating_century_end_id] = "century"
		attributes[:is_dating_timespan_unknown] = "timespan begin"
		attributes[:main_path_id] = "kind of object specified"
		attributes[:inscription_decoration] = "decoration of inscription"
		attributes[:material] = "material"
		attributes[:color_id] = "color"
		attributes[:description] = "description"
		attributes[:name_expedition] = "other site name"

		ap attributes

		xlsx = Roo::Spreadsheet.open(file)
		default_sheet = nil
		xlsx.sheets.each do |sheet|
			if sheet.include? "import"
				default_sheet = sheet
			end
		end

		if default_sheet.blank?
			Rails.logger.error "Could not find an 'import' sheet. Aborting"
			return
		else
			Rails.logger.info "Using sheet for import: #{default_sheet}"
			xlsx.default_sheet = default_sheet
		end

		Rails.logger.info "Trying to match columns..."
		unused_columns = xlsx.row(1).deep_dup
		attributes.keys.each do |attribute_name|
			attribute_column_name = attributes[attribute_name]
			if !xlsx.row(1).include? attribute_column_name
				Rails.logger.warn "Could not find column for attribute #{attribute_name}"
				Rails.logger.warn "Was looking for: #{attribute_column_name}"
				attributes.delete(attribute_name)
			else
				unused_columns.delete(attribute_column_name)
			end
		end
		if unused_columns.present?
			Rails.logger.warn "Unused columns: #{unused_columns.inspect}"
		end

		i = 0
		xlsx.each(attributes) do |row|
			i+=1
			Rails.logger.info "Importing line #{i.to_s}..." if i % 100 == 0
			row.keys.each do |key|
			end
		end
	end

end
