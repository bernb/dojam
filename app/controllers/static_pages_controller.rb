class StaticPagesController < ApplicationController
	include TermlistsImporterHelper
  def menu
  end

	def import_termlists_select
	end

	def import_termlists_submit
		file_array = []
		params.dig(:termlists, :termlist_files).each do |file_path|
			file = file_path.tempfile
			if File.extname(file) == ".rb"
				file = File.open file_path.tempfile
				file_array << file unless file.blank?
			else
				flash[:warning] = "Unsupported file formats detected. Only .rb files are supported."
			end
		end
		file_array.each do |file|
			require file.path
		end
		material_attributes = find_all_attributes
		global_material_variables_array.each do |material_data|
			Rails.logger.info "Importing variable " + material_data.to_s
			# Eval as material_data is given as a symbol
			material_import(eval(material_data.to_s), material_attributes)
		end
		flash[:success] = "Uploaded #{file_array.count} files." unless file_array.blank?
		redirect_to import_termlists_select_path
	end
end
