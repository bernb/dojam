# ***************************
# *** museum and storages ***
# ***************************

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
