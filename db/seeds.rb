Dir["#{Rails.root}/db/data/*.rb"].reject{|file| file.include? "test"}.each {|file| require file}

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
#$excavation_site_names.each do |sitename|
#  ExcavationSite.find_or_create_by name: sitename
#end
#
#$site_kinds.each do |category_name, kinds_array|
#  category = ExcavationSiteCategory.find_or_create_by name: category_name
#  kinds_array.each do |site_kind_name|
#    site_kind = ExcavationSiteKind.find_or_create_by name: site_kind_name
#    category.termlist_excavation_site_kinds << site_kind
#  end
#  site_kind = ExcavationSiteKind.find_or_create_by name: "Unspecific/Unknown"
#  category.termlist_excavation_site_kinds << site_kind
#end


# ******************
# *** Priorities ***
# ******************
Priority.find_or_create_by(name: "1")
Priority.find_or_create_by(name: "2")
Priority.find_or_create_by(name: "3")
Priority.find_or_create_by(name: "4")
Priority.find_or_create_by(name: "5")

# ************************************
# Data to be added for all koos/ms ***
# ************************************
def import_other_data
#	MaterialSpecifiedsKooSpec.all.each do |mskoo|
#		$data_dating[:periods].each do |period|
#			p =	DatingPeriod.find_or_create_by(name: period)
#			mskoo.termlist_dating_periods.find_by(name: p.name) || mskoo.termlist_dating_periods << p
#		end
#		$data_dating[:millennia].each do |millennium|
#			m = DatingMillennium.find_or_create_by(name: millennium)
#			mskoo.termlist_dating_millennia.find_by(name: m.name) || mskoo.termlist_dating_millennia << m
#		end
#		$data_dating[:centuries].each do |century|
#			c = DatingCentury.find_or_create_by(name: century)
#			mskoo.termlist_dating_centuries.find_by(name: c.name) || mskoo.termlist_dating_centuries << c
#		end
#		deco_color = DecorationColor.find_or_create_by(name: "none")
#		deco_technique = DecorationTechnique.find_or_create_by(name: "none")
#		deco_style = Decoration.find_or_create_by(name: "none")
#		inscr_lang = InscriptionLanguage.find_or_create_by(name: "none")
#		inscr_letter = InscriptionLetter.find_or_create_by(name: "none")
#
#		mskoo.termlist_decoration_colors << deco_color
#		mskoo.termlist_decoration_techniques << deco_technique
#		mskoo.termlist_decorations << deco_style
#		mskoo.termlist_inscription_languages << inscr_lang
#		mskoo.termlist_inscription_letters << inscr_letter
#	end
end


def import_material data 
	if data[:material_name].empty?
		Rails.logger.error "*** No material given with data hash. ***"
		Rails.logger.error "Given data hash: " + data.to_s
		return
	end
	path = "/"
	material = Material.find_or_create_by(name: data[:material_name])
	data[:material_specifieds].each.with_index(1)  do |ms_name, index|
		material_specified = MaterialSpecified.create name: ms_name
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
			end # koos	
		else # if not hash
			koo = KindOfObject.find_or_create_by name: koo_name
			material_specified.attach_child koo
			path = PathGetter.call material: material, material_specified: material_specified, kind_of_object: koo
		end # if not hash

		data.keys.reject{|var| var.to_s.starts_with?("material") || var.to_s.starts_with?("kind_of_object")}.each do |termlist|
			classname = termlist.to_s.classify.constantize
			data[termlist].each do |name|
				t = classname.find_or_create_by name: name
				p = Path.find_or_create_by path: path
				t.paths << p
			end
		end

	end # each kind of object
	end # each material specified
end
 
global_variables.select{|var| var.to_s.ends_with? "_data"}
								.reject{|var| var.to_s.include? "test"}
								.each do |material_data|
	Rails.logger.info "Importing variable " + material_data.to_s
	import_material eval(material_data.to_s)
end
