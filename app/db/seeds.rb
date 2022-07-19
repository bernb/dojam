# Create dummy entries as the existence of at least one entry is necessary for the application to function as intended
storage_location = StorageLocation.create_or_find_by name_en: "undefined"
storage = Storage.create_or_find_by name_en: "undefined"
museum = Museum.create_or_find_by name: "undefined"
storage.storage_locations << storage_location
museum.storages << storage


term_categories = %w[
AcquisitionDeliveredBy
AcquisitionKind
Authenticity Color
DatingCentury
DatingMillennium
DatingPeriod
Decoration
DecorationColor
DecorationTechnique
ExcavationSiteCategory
ExcavationSiteKind
InscriptionLanguage
InscriptionLetter
PreservationMaterial
PreservationObject
Priority
ProductionTechnique]

base_categories = %w[
Material
MaterialSpecified
KindOfObject
KindOfObjectSpecified
]

# Create 'undetermined' terms that work as default values.
# A base categories' path is only to itself, ever. All other categories can have multiple paths and get seeded their
# default path here, the 'undetermined path' with named_path == '/undetermined/undetermined/undetermined/undetermined'.
(term_categories + base_categories).each do |category|
  category.constantize.create_or_find_by name_en: "undetermined"
end

m = Material.first
ms = MaterialSpecified.first
koo = KindOfObject.first
koos = KindOfObjectSpecified.first

# There exists an after_create callback in Termlist model for materials.
#m.paths   << Path.create_or_find_by(path: "/#{m.id}")
ms.paths  << Path.create_or_find_by(path: "/#{m.id}/#{ms.id}")
koo.paths << Path.create_or_find_by(path: "/#{m.id}/#{ms.id}/#{koo.id}")
undetermined_path = Path.create_or_find_by(path: "/#{m.id}/#{ms.id}/#{koo.id}/#{koos.id}")
koos.paths << undetermined_path

term_categories.each do |term_category|
  term_class = term_category.constantize
  term_class.first.paths << undetermined_path unless term_class.is_independent_of_paths
end