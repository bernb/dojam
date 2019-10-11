class StaticPagesController < ApplicationController
	include TermlistsImporterHelper
  def menu
  end

  def reports
    @museum_objects = MuseumObject.order(:created_at)
      .limit(10)
      .decorate
  end

	def import_termlists_select
	end

	def import_termlists_submit
		flash[:warning] = Hash.new
		materials_for_import = []
		materials_for_import, warnings =
		 	parse_import_files params.dig(:termlists, :termlist_files)
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
		materials_for_import&.each do |material_hash|
			log_files << material_import(material_hash, material_attributes)
		end
		flash[:warning] = warnings
		if materials_for_import.present?
		flash[:success] = "Uploaded #{materials_for_import.count} files"
		end
		redirect_to import_termlists_select_path
	end
end
