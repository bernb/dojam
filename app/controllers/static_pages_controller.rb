class StaticPagesController < ApplicationController
	include TermlistsImporterHelper
  def menu
  end

	def import_termlists_select
	end

	def import_termlists_submit
		flash[:warning] = Hash.new
		materials_for_import = []
		params.dig(:termlists, :termlist_files)&.each do |file_path|
			file = file_path.tempfile
			if File.extname(file) == ".yaml"
				file = File.open file_path.tempfile
				material_data = YAML.load_file file
				# We used symbols as keys in original termlist rb files
				# but it's a bit ugly in yaml files as additional colon would be
				# needed to achieve this
				material_data.transform_keys!(&:to_sym)
				materials_for_import << material_data
			else
				flash[:warning][:unsupported_file] = "Unsupported file formats detected. Only yaml files are supported."
			end
		end
		material_attributes = [
			:material_name,
			:material_specifieds,
			:kind_of_objects,
			:production_techniques,
			:decorations,
			:colors,
			:decoration_colors,
			:decoration_techniques,
			:preservation_materials,
			:preservation_objects
		]
		log_files = []
		materials_for_import.each do |material_hash|
			log_files << material_import(material_hash, material_attributes)
		end
		if materials_for_import.blank?
			flash[:warning][:no_valid_files] = "No valid files for import found"
		else
			flash[:success] = "Uploaded #{materials_for_import.count} files." unless materials_for_import.blank?
		end
	end
end
