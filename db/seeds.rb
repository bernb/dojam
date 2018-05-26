# require "#{Rails.root}/db/seeds/seed_museums.rb"
 require "#{Rails.root}/db/seeds/seed_materials.rb"
# require "#{Rails.root}/db/seeds/seed_storages.rb"
# require "#{Rails.root}/db/seeds/seed_sites.rb"
# require "#{Rails.root}/db/seeds/seed_dating.rb"
# require "#{Rails.root}/db/seeds/seed_other_termlists.rb"
if Rails.env.development?
# require "#{Rails.root}/db/seeds/museum_object_generator.rb"
end

def import_material data 
	puts "*** Material: " + data[:material_name] + "***"
	material = TermlistMaterial.find_or_create_by(name: "data[:material_name]")
	data[:material_specifieds].each  do |ms_name|
		puts "*** Material specified: " + ms_name + "***"
		ms = material.termlist_material_specifieds.find_or_create_by(name: ms_name)
		puts "Importing kind of object data..."
		import_kind_of_objects data, ms
	end # each material specified
end

def import_colors data, koos 
	data.each do |color_name|
		color = TermlistColor.find_or_create_by(name: color_name) 
		koos.props.each.termlist_colors << color
	end
end

def import_kind_of_objects data, material_specified
	data[:kind_of_objects].each do |koo_name|
		# if entry is hash, kind of object specifieds are present
		if koo_name.is_a? Hash
			# Look if koo with same name already exists, otherwise create
			# Note that hash always only has single key for koo name
			koo = TermlistKindOfObject.find_or_create_by(name: koo_name.keys.first)
			# Now find or create kind of object specified as defined in has
			# values[0] gives values of the first and only key (koo)
			koo_name.values[0].each do |koos_name|
				koos = TermlistKindOfObjectSpecified.find_or_create_by(name: koos_name)
				# Insert accordingly: |ms|---<|koos|>---|koo|
				koo.termlist_kind_of_object_specifieds << koos
				material_specified.termlist_kind_of_object_specifieds << koos
				import_colors data[:colors], koos
			end # koos	
		else # if not hash
			# If not a hash, no koo specified were defined
			# Thus we create a dummy koo specified with the same name as the koo
			# to ensure 1..* relationship, as the join table between ms and koos
			# is the entry point for all other properties, a koos must always be present
			koos = TermlistKindOfObjectSpecified.find_or_create_by(name: koo_name)
			koo = TermlistKindOfObject.find_or_create_by(name: koo_name)
			koo.termlist_kind_of_object_specifieds << koos
		end # if not hash
	end # each kind of object
end
 
import_material $ceramic_data 

=begin                    

termlist_preservations = ["complete", "fragmentary"]
termlist_preservations.each do |preservation|
  TermlistPreservation.create name: preservation
end

termlist_conservations = ["no", "yes", "partially", "cleaned", "consolidated", "needed", "unknown"]
termlist_conservations.each do |conservation|
  TermlistConservation.create name: conservation
end

termlist_dating_period = ["Palaeolithic", "Mesolithic", "Neolithic", "Chalcolithic",
                          "Bronze Age", "Early Bronze Age", "Middle Bronze Age",
                          "Late Bronze Age", "Iron Age", "Early Iron Age",
                          "Late Iron Age", "Hellenistic", "Nabataean", "Roman",
                          "Byzantine", "Umayyad", "Abbasid", "Ayyubid", "Mamluk",
                          "Ottoman", "Modern"]

termlist_dating_period.each do |period|
  TermlistDatingPeriod.create name: period
end


termlist_dating_millennium = [ "10th mill. BC", "9th mill. BC", "8th mill. BC", 
                               "7th mill. BC", "6th mill. BC", "5th mill. BC",
                               "4th mill. BC", "3rd mill. BC", "2nd mill. BC",
                               "1st mill. BC", "1st mill. AD", "2nd mill. AD"]

termlist_dating_millennium.each do |millennium|
  TermlistDatingMillennium.create name: millennium
end

=end
