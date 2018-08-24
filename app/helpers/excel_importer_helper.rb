module ExcelImporterHelper
	require 'roo'
	include ExcelImporterHelperHelper

	def import_excel_from_file file
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
		@@attributes.keys.each do |attribute_name|
			attribute_column_name = @@attributes[attribute_name]
			if !xlsx.row(1).include? attribute_column_name
				Rails.logger.warn "Could not find column for attribute #{attribute_name}"
				Rails.logger.warn "Was looking for: #{attribute_column_name}"
				@@attributes.delete(attribute_name)
			else
				unused_columns.delete(attribute_column_name)
			end
		end
		if unused_columns.present?
			Rails.logger.warn "Unused columns: #{unused_columns.inspect}"
		end

		i = 0
		logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

		# Note that this is a roo specific method each(), unfortunately we can't use any of
		# the many variants ruby gives us for arrays or ranges, like skipping the first and alike
		xlsx.each(@@attributes) do |row|
			i+=1
			if i==1 then next end

			if row[:inv_number].blank?
				logger.tagged("Row #{i.to_s}"){logger.warning "Can not import without inventory number. Skipping..."}
				next
			end

			sherdname = build_sherdname row
			logger.tagged("Row #{i.to_s}"){logger.info "Importing #{sherdname} from file"}

			object = MuseumObject.where(inv_number: row[:inv_number]).where(inv_extension: row[:inv_extension]).first
			if object.present?
				logger.tagged("Row #{i.to_s}"){logger.info "Found in database, updating entry"}
			else
				logger.tagged("Row #{i.to_s}"){logger.info "Create new entry"}
				object = MuseumObject.new(inv_number: row[:inv_number], inv_extension: row[:inv_extension])
			end


			material, material_specified, kind_of_object, kind_of_object_specified = assign_material_related_termlists row, i
			if material.blank? || material_specified.blank? || kind_of_object.blank? || kind_of_object_specified.blank?
				next
			end
			path = Path.find_by_material_related material, material_specified, kind_of_object, kind_of_object_specified
			if path.blank?
				logger.tagged("Row #{i.to_s}"){logger.warning "Could not find path /#{material.name}/#{material.specified.name}/#{kind_of_object.name}/#{kind_of_object_specified.name}. Skipping row..."}
				next
			end

			object.main_path = path

			row.keys.each do |key|
				if is_simple_attribute key
					object.send(key.to_s+"=", row[key])
				elsif is_regular_termlist key
					set_association object: object, column: key, termlist_value: row[key], current_line: i unless row[key].blank?
				elsif is_complex_termlist key
					next
				end
			end # row.keys.each

			if object.save 
				logger.tagged("Row #{i.to_s}"){logger.debug "Saved with id #{object.id}"}
			else
				logger.tagged("Row #{i.to_s}"){logger.error "Could not save object: #{object.errors.full_messages}"}
			end

		end # xlsx.each
	end

end
