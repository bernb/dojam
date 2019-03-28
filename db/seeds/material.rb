Dir["#{Rails.root}/db/data/termlists/**/*.rb"].reject{|file| file.include?("test") || file.include?("general") || File.directory?(file) }.each {|file| require file}
require "#{Rails.root}/app/helpers/termlists_importer_helper.rb"
include TermlistsImporterHelper

Rails.logger.info "*** Starting material import ***"
# We first determine which keys/attributes are found over all file
# as some files do not contain all attributes, but we want to build 'undetermined'
# paths for every attribute, even if it's missing in the file
material_attributes = find_all_attributes
global_material_variables_array.each do |material_data|
	Rails.logger.info "Importing variable " + material_data.to_s
	# Eval as material_data is given as a symbol
	material_import(eval(material_data.to_s), material_attributes)
end
Rails.logger.info "*** Finished material import ***"
