require "#{Rails.root}/db/data/ceramic.rb"
require "#{Rails.root}/db/data/metal.rb"
require "#{Rails.root}/db/data/organic.rb"
require "#{Rails.root}/db/data/stone.rb"
require "#{Rails.root}/db/data/vitreous.rb"
require "#{Rails.root}/db/data/dating.rb"
require "#{Rails.root}/db/data/sites.rb"
require "#{Rails.root}/db/data/test.rb"
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


# ************************************
# Data to be added for all koos/ms ***
# ***********************************
def import_other_data
	MaterialSpecifiedsKooSpec.all.each do |mskoo|
		$data_dating[:periods].each do |period|
		p =	TermlistDatingPeriod.find_or_create_by(name: period)
		mskoo.termlist_dating_periods.find_by(name: p.name) || mskoo.termlist_dating_periods << p
		end
		$data_dating[:millennia].each do |millennium|
			m = TermlistDatingMillennium.find_or_create_by(name: millennium)
			mskoo.termlist_dating_millennia.find_by(name: m.name) || mskoo.termlist_dating_millennia << m
		end
		$data_dating[:centuries].each do |century|
			c = TermlistDatingCentury.find_or_create_by(name: century)
			mskoo.termlist_dating_centuries.find_by(name: c.name) || mskoo.termlist_dating_centuries << c
		end
	end
end


def import_material data 
	Rails.logger.info "*** Material: " + data[:material_name] + "***"
	material = TermlistMaterial.find_or_create_by(name: data[:material_name])
	count = data[:material_specifieds].count
	data[:material_specifieds].each.with_index(1)  do |ms_name, index|
		Rails.logger.info "*** Material specified: " + ms_name + " (" + index.to_s + "/" + count.to_s + ") ***"
		ms = material.termlist_material_specifieds.find_or_create_by(name: ms_name)
		Rails.logger.info "Importing kind of object data..."
		import_kind_of_objects data, ms
	end # each material specified
end

def import_properties class_name, data, koos, ms 
	data.each do |prop_name|
		# As this is only for initlal seeding we are
		# sloppy here and just call with given class_name
		# find or create concrete property like a production technique or color
		prop = Object.const_get(class_name).find_or_create_by(name: prop_name) 
		# creates ':colors' from 'TermlistColor'
		method_symbol = class_name.underscore.pluralize.to_sym
		PropsSetter.call property: prop, property_name: method_symbol, koos: koos, material_specified: ms
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
				# Iterate over all hashes/properties, but
				# exclude material and kind related stuff
				rejects = lambda {|h| h.to_s.starts_with?("kind") || h.to_s.starts_with?("material")}
				data.keys.reject(&rejects).each do |prop_name|
					import_properties "Termlist" + prop_name.to_s.camelize.singularize, data[prop_name], koos, material_specified
				end
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
 
import_material $test_data 
# import_material $metal_data 
# import_material $organic_data
# import_material $stone_data
# import_material $vitreous_data
import_other_data
