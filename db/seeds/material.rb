Dir["#{Rails.root}/db/data/*.rb"].reject{|file| file.include?("test") || file.include?("general") }.each {|file| require file}

Rails.logger.info "*** Starting material import ***"
global_variables.select{|var| var.to_s.ends_with? "_material_data"}
								.reject{|var| var.to_s.include? "test"}
								.each do |material_data|
	Rails.logger.info "Importing variable " + material_data.to_s
	# Eval as material_data is given as a symbol
	material_import eval(material_data.to_s)
end
Rails.logger.info "*** Finished material import ***"
