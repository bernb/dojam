module ExcelImporterHelper
	require 'roo'

	def import_excel_from_file file

		attributes = {}
		MuseumObject.columns.each do |column|
			attributes[column.name] = nil
		end	

		attributes[:inv_number] = "inventory number of museum"
		attributes[:inv_extension] = "extension of inventory number"
		attributes[:inv_numberdoa] = "other inventory number"
		attributes[:amount] = "number of objects"
		attributes[:finding_context] = "finding context specified"
		attributes[:finding_remarks] = "remarks"
		attributes[:description_authenticities_name] = nil
		attributes[:description_conservation] = nil
		attributes[:description_preservation_state_name] = nil
		attributes[:acquisition_deliverer_name] = "delivered by"
		attributes[:storage_location_id] = "storage location"
		attributes[:storage_general_location_dummy] = "detailed location"
		attributes[:excavation_site_id] = nil
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
		attributes[:main_material_specified_id] = "material_specified


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
		# Iterate through first row and find matches for attributes
#		xlsx.first.each do |column|
#			mathed_columns = xlsx.first
#			# First check simplest case: column matches perfectly the attribute
#			if attributes.has_key? column || attributes.has_key?(column.parameterize(separator: '_'))
#				attributes[column] = column
#			end
#
#		end
		ap(attributes)
	end

end
