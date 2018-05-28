require "#{Rails.root}/db/data/ceramic.rb"
require "#{Rails.root}/db/data/sites.rb"
# require "#{Rails.root}/db/seeds/seed_dating.rb"
if Rails.env.development?
# require "#{Rails.root}/db/seeds/museum_object_generator.rb"
end


# ***************************
# *** museum and storages ***
# ***************************
museum = Museum.find_or_create_by name: "JAM", prefix: "J"

TermlistAcquisitionKind.find_or_create_by name: "chance find"
TermlistAcquisitionKind.find_or_create_by name: "confiscation"
TermlistAcquisitionKind.find_or_create_by name: "excavation"
TermlistAcquisitionKind.find_or_create_by name: "gift"
TermlistAcquisitionKind.find_or_create_by name: "purchase"
TermlistAcquisitionKind.find_or_create_by name: "archaeological survey"
TermlistAcquisitionKind.find_or_create_by name: "unknown"

TermlistAcquisitionDeliveredBy.find_or_create_by name: "excavator"
TermlistAcquisitionDeliveredBy.find_or_create_by name: "donor"
TermlistAcquisitionDeliveredBy.find_or_create_by name: "seller"
TermlistAcquisitionDeliveredBy.find_or_create_by name: "institution"
TermlistAcquisitionDeliveredBy.find_or_create_by name: "unknown"

TermlistAuthenticity.find_or_create_by name: "archaeological object"
TermlistAuthenticity.find_or_create_by name: "copy"
TermlistAuthenticity.find_or_create_by name: "forgery"
TermlistAuthenticity.find_or_create_by name: "unspecific"
TermlistAuthenticity.find_or_create_by name: "unknown"

storages = []

storageA = Storage.find_or_create_by name: "hall A"
storageB = Storage.find_or_create_by name: "hall B"
storageC = Storage.find_or_create_by name: "hall C"
storages << storageA
storages << storageB
storages << storageC


(1..28).each do |n|
  letter = storageA.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.find_or_create_by name: "showcase " + letter + n.to_s
  storageA.storage_locations << location
end


(1..5).each do |n|
  letter = storageB.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.find_or_create_by name: "showcase " + letter + n.to_s
  storageB.storage_locations << location
end

(1..11).each do |n|
  letter = storageC.name[-1] # counts backwards the string thus gets the last char
  location = StorageLocation.find_or_create_by name: "showcase " + letter + n.to_s
  storageC.storage_locations << location
end

museum.storages << storages
museum.save!

# ***************************************
# *** excavation sites and site kinds ***
# ***************************************
$excavation_site_names.each do |sitename|
  ExcavationSite.find_or_create_by name: sitename
end

$site_kinds.each do |category_name, kinds_array|
  category = TermlistExcavationSiteCategory.find_or_create_by name: category_name
  kinds_array.each do |site_kind_name|
    site_kind = TermlistExcavationSiteKind.find_or_create_by name: site_kind_name
    category.termlist_excavation_site_kinds << site_kind
  end
  site_kind = TermlistExcavationSiteKind.find_or_create_by name: "Unspecific/Unknown"
  category.termlist_excavation_site_kinds << site_kind
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
		koos.insert_properties :termlist_colors, color
	end
end

def import_kind_of_objects data, material_specified
	data[:kind_of_objects].each do |koo_name|
		# if entry is hash, kind of object specifieds are present
		if koo_name.is_a? Hash
			# Look if koo with same name already exists, otherwise create
			# Note that hash always only has single key for koo name
			koo = TermlistKindOfObject.find_or_create_by(name: koo_name.keys.first)
			# Now find or.find_or_create_by kind of object specified as defined in has
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
			# Thus we.find_or_create_by a dummy koo specified with the same name as the koo
			# to ensure 1..* relationship, as the join table between ms and koos
			# is the entry point for all other properties, a koos must always be present
			koos = TermlistKindOfObjectSpecified.find_or_create_by(name: koo_name)
			koo = TermlistKindOfObject.find_or_create_by(name: koo_name)
			koo.termlist_kind_of_object_specifieds << koos
			material_specified.termlist_kind_of_object_specifieds << koos
		end # if not hash
	end # each kind of object
end
 
import_material $ceramic_data 

=begin                    

termlist_preservations = ["complete", "fragmentary"]
termlist_preservations.each do |preservation|
  TermlistPreservation.find_or_create_by name: preservation
end

termlist_conservations = ["no", "yes", "partially", "cleaned", "consolidated", "needed", "unknown"]
termlist_conservations.each do |conservation|
  TermlistConservation.find_or_create_by name: conservation
end

termlist_dating_period = ["Palaeolithic", "Mesolithic", "Neolithic", "Chalcolithic",
                          "Bronze Age", "Early Bronze Age", "Middle Bronze Age",
                          "Late Bronze Age", "Iron Age", "Early Iron Age",
                          "Late Iron Age", "Hellenistic", "Nabataean", "Roman",
                          "Byzantine", "Umayyad", "Abbasid", "Ayyubid", "Mamluk",
                          "Ottoman", "Modern"]

termlist_dating_period.each do |period|
  TermlistDatingPeriod.find_or_create_by name: period
end


termlist_dating_millennium = [ "10th mill. BC", "9th mill. BC", "8th mill. BC", 
                               "7th mill. BC", "6th mill. BC", "5th mill. BC",
                               "4th mill. BC", "3rd mill. BC", "2nd mill. BC",
                               "1st mill. BC", "1st mill. AD", "2nd mill. AD"]

termlist_dating_millennium.each do |millennium|
  TermlistDatingMillennium.find_or_create_by name: millennium
end

=end
