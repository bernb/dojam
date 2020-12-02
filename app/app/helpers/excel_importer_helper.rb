module ExcelImporterHelper
	require 'roo'
	include ExcelImporterHelperHelper

	def import_excel_from_file file, ignore_keys: nil
		logger = ActiveSupport::TaggedLogging.new(Logger.new("#{Rails.root}/log/excel_importer.log"))
		xlsx = Roo::Spreadsheet.open(file)
		default_sheet = nil
		xlsx.sheets.each do |sheet|
			if sheet.include? "import"
				default_sheet = sheet
			end
		end

		if ignore_keys.present?
			@@attributes.reject!{|a| ignore_keys.include? a}
		end

		if default_sheet.blank?
			logger.error "Could not find an 'import' sheet. Aborting"
			return
		else
			logger.info "Using sheet for import: #{default_sheet}"
			xlsx.default_sheet = default_sheet
		end

		logger.info "Trying to match columns..."
		unused_columns = xlsx.row(1).deep_dup
		@@attributes.keys.each do |attribute_name|
			if attribute_name == :name_expedition
				#debugger
			end
			attribute_column_name = @@attributes[attribute_name]
			if !xlsx.row(1).include? attribute_column_name
				logger.warn "Could not find column for attribute #{attribute_name}"
				logger.warn "Was looking for: #{attribute_column_name}"
				@@attributes.delete(attribute_name)
			else
				unused_columns.delete(attribute_column_name)
			end
		end
		if unused_columns.present?
			logger.warn "Unused columns: #{unused_columns.inspect}"
		end

		i = 0

		# Note that this is a roo specific method each(), unfortunately we can't use any of
		# the many variants ruby gives us for arrays or ranges, like skipping the first and alike
		xlsx.each(@@attributes) do |row|
			i+=1
			if i==1 then next end


			if row[:inv_number].blank?
				logger.tagged("Row #{i.to_s}"){logger.warn "Can not import without inventory number. Skipping..."}
				next
			end


			sherdname = build_sherdname row
			#logger.tagged("Row #{i.to_s}"){logger.info "Importing #{sherdname} from file"}

			object = MuseumObject.where(inv_number: row[:inv_number]).where(inv_extension: row[:inv_extension]).first
			if object.present?
				#logger.tagged("Row #{i.to_s}"){logger.info "Found in database, updating entry"}
			else
			#logger.tagged("Row #{i.to_s}"){logger.info "Creating new entry"}
				object = MuseumObject.new(inv_number: row[:inv_number], inv_extension: row[:inv_extension])
			end

			# Set museum related properties like storage location or
			# inventory number
			set_museum_properties object, row
			if object.errors.size > 0
				#logger.tagged("Row #{i.to_s}", "Warning"){logger.warn "Could not save object:"}
				object.errors.full_messages.each do |message|
					logger.tagged("Row #{i.to_s}", object.decorate.full_inv_number){logger.warn message}
				end
				next
			end


			# Try to assign a main_path
			set_main_path object, row
			if object.errors.size > 0
				object.errors.full_messages.each do |message|
					logger.tagged("Row #{i.to_s}", object.decorate.full_inv_number){logger.warn message}
				end
				#logger.tagged("Row #{i.to_s}"){logger.warn "Skipping termlists..."}
				next
			end

			row.keys.each do |key|
				if is_simple_attribute key
					if is_correct_format key, row[key]
						object.send(key.to_s+"=", row[key])
					else
						object.errors[:base] << "Invalid format \"#{row[key]}\" for #{key}"
					end
				elsif is_regular_termlist key
					set_association object: object, column: key, termlist_value: row[key], current_line: i unless row[key].blank?
				elsif is_complex_attribute key
					case key
					when :needs_cleaning, :needs_conservation
						set_boolean_for object, key, row[key]
					when :dating_millennium
						set_millennium_data object: object, value: row[key]
					when :dating_century
						set_century_data object: object, value: row[key]
					when :dating_timespan_begin
						set_timespan_data object: object, begin_value: row[key], end_value: row[:dating_timespan_end]
					when :colors
						colors = split_entry row[key]
						set_color(object: object, values: colors) unless colors.blank?
					when :secondary_material
						if row[key].present?
							material = Material.find_by name_en: row[key]
							if material.blank?
								object.errors[:base] << "Could not find secondary material #{row[key]}"
							else
								# Right now materials (specified) has kind of weird interface
								object.materials = [material]
							end
						end # row[key] present
					when :main_material_specified
						if row[key].include?(',')
							ms_name = split_entry(row[key])[1]
							ms = MaterialSpecified.find_by name_en: ms_name
							if ms.blank?
								object.errors[:base] << "Could not find secondary material specified #{ms_name}"
							else 
								object.material_specifieds = [ms]
							end
						end # row[:main_material_specified] include ','
					when :production_technique, :decoration_color, :decoration_technique, :dating_period
						values = split_entry(row[key])
						set_association object: object, column: key, termlist_value: values[0], current_line: i unless values[0].blank?
					end # case key
				end # complex attribute
			end # row.keys.each

			if object.errors.size > 0
				object.errors.full_messages.each do |message|
					logger.tagged("Row #{i.to_s}", object.decorate.full_inv_number){logger.warn message}
				end
				#logger.tagged("Row #{i.to_s}"){logger.warn "Setting unfinished flag for this object"}
			else
				object.is_finished = true
			end

			if object.save 
				#logger.tagged("Row #{i.to_s}"){logger.debug "Saved with id #{object.id}"}
			else
				logger.tagged("Row #{i.to_s}", object.decorate.full_inv_number){logger.error "Could not save object: #{object.errors.full_messages}"}
			end

		end # xlsx.each
	end

end
