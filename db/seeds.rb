Dir["#{Rails.root}/db/data/*.rb"].reject{|file| file.include? "test"}.each {|file| require file}
require "#{Rails.root}/db/data/material_test.rb"

# ***************************
# *** museum and storages ***
# ***************************
museum = Museum.find_or_create_by name: "JAM", prefix: "J"

AcquisitionKind.find_or_create_by name: "chance find"
AcquisitionKind.find_or_create_by name: "confiscation"
AcquisitionKind.find_or_create_by name: "excavation"
AcquisitionKind.find_or_create_by name: "gift"
AcquisitionKind.find_or_create_by name: "purchase"
AcquisitionKind.find_or_create_by name: "archaeological survey"
AcquisitionKind.find_or_create_by name: "unknown"

AcquisitionDeliveredBy.find_or_create_by name: "excavator"
AcquisitionDeliveredBy.find_or_create_by name: "donor"
AcquisitionDeliveredBy.find_or_create_by name: "seller"
AcquisitionDeliveredBy.find_or_create_by name: "institution"
AcquisitionDeliveredBy.find_or_create_by name: "unknown"

Authenticity.find_or_create_by name: "archaeological object"
Authenticity.find_or_create_by name: "copy"
Authenticity.find_or_create_by name: "forgery"
Authenticity.find_or_create_by name: "unspecific"
Authenticity.find_or_create_by name: "unknown"

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
  category = ExcavationSiteCategory.find_or_create_by name: category_name
  kinds_array.each do |site_kind_name|
    site_kind = ExcavationSiteKind.find_or_create_by name: site_kind_name
    category.excavation_site_kinds << site_kind
  end
  site_kind = ExcavationSiteKind.find_or_create_by name: "Unspecific/Unknown"
  category.excavation_site_kinds << site_kind
end


# ******************
# *** Priorities ***
# ******************
Priority.find_or_create_by(name: "1")
Priority.find_or_create_by(name: "2")
Priority.find_or_create_by(name: "3")
Priority.find_or_create_by(name: "4")
Priority.find_or_create_by(name: "5")

# *******************
# *** Dating data ***
# *******************
def import_dating_data
	$data_dating[:periods].each do |period|
		p =	DatingPeriod.find_or_create_by(name: period)
	end
	$data_dating[:millennia].each do |millennium|
		m = DatingMillennium.find_or_create_by(name: millennium)
	end
	$data_dating[:centuries].each do |century|
		c = DatingCentury.find_or_create_by(name: century)
	end
end

def termlist_names data, all = false
	if all
		data.keys
	else
		data.keys.reject{|var| var.to_s.starts_with?("material") || var.to_s.starts_with?("kind_of_object")}
	end
end

def build_termlists data, path
	p = Path.find_or_create_by path: path
	termlist_names(data).each do |termlist|
		classname = termlist.to_s.classify.constantize
		data[termlist].each do |name|
			t = classname.find_or_create_by name: name
			t.paths << p
		end
		# Create undetermined entry by default
		# This was too slow and made termlist_paths table 2,5 the size it was so we now
		# merge undetermined entries within the museum_object model when getting possible properties
		 undetermined_entry = classname.find_or_create_by name: "undetermined"
		 undetermined_entry.paths << p
	end
end

def import_material data 
	if data[:material_name].empty?
		Rails.logger.error "*** No material given with data hash. ***"
		Rails.logger.error "Given data hash: " + data.to_s
		return
	end
	path = "/"
	material = Material.find_or_create_by(name: data[:material_name])
	data[:material_specifieds].each do |ms_name|
		material_specified = MaterialSpecified.find_or_create_by name: ms_name
		material.attach_child material_specified
		data[:kind_of_objects].each do |koo_name|
			# if entry is hash, kind of object specifieds are present
			if koo_name.is_a? Hash
				koo = KindOfObject.find_or_create_by name: koo_name.keys[0].to_s
				material_specified.attach_child koo
				koo_name.values[0].each do |koos_name|
					koos = KindOfObjectSpecified.find_or_create_by name: koos_name
					koo.attach_child koos
					path = PathGetter.call material: material, material_specified: material_specified, kind_of_object: koo, kind_of_object_specified: koos
					build_termlists data, path
				end # koos	
			else # if not hash
				koo = KindOfObject.find_or_create_by name: koo_name
				material_specified.attach_child koo
				path = PathGetter.call material: material, material_specified: material_specified, kind_of_object: koo
				build_termlists data, path
			end # if not hash
			undetermined_koos = KindOfObjectSpecified.find_or_create_by name: "undetermined"
			koo.attach_child undetermined_koos

		end # each kind of object
	end # each material specified

	# We create undetermined entries by default without saving all paths in termlist_paths
	# As this made the table size much bigger and was slow to seed
	# This created some problems i.e. setting main_path to nil
	# if kind of object specified was choosen undetermined
	#	termlist_names(data).each do |termlist|
	#		classname = termlist.to_s.classify.constantize
	#		data[termlist].each do |name|
	#		classname.find_or_create_by name: "undetermined"
	#		end
	#		# Above lines did not cover koos edge case
	#		KindOfObjectSpecified.find_or_create_by name: "undetermined"
	#	end

end
 
global_variables.select{|var| var.to_s.ends_with? "_data"}
								.reject{|var| var.to_s.include? "test"}
								.each do |material_data|
	Rails.logger.info "Importing variable " + material_data.to_s
	import_material eval(material_data.to_s)
	import_dating_data
end
#import_material $test_data
