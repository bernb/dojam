storage_location = StorageLocation.create_or_find_by name_en: "undefined"
storage = Storage.create_or_find_by name_en: "undefined"
museum = Museum.create_or_find_by name: "undefined"
storage.storage_locations << storage_location
museum.storages << storage


term_categories = ["AcquisitionDeliveredBy",
                   "AcquisitionKind",
                   "Authenticity",
                   "Color",
                   "DatingCentury",
                   "DatingMillennium",
                   "DatingPeriod",
                   "Decoration",
                   "DecorationColor",
                   "DecorationTechnique",
                   "ExcavationSiteCategory",
                   "ExcavationSiteKind",
                   "InscriptionLanguage",
                   "InscriptionLetter",
                   "KindOfObject",
                   "KindOfObjectSpecified",
                   "Material",
                   "MaterialSpecified",
                   "PreservationMaterial",
                   "PreservationObject",
                   "Priority",
                   "ProductionTechnique"]


term_categories.each do |term_category|
  term_category.constantize.create_or_find_by name_en: "undetermined"
end

m = Material.first
ms = MaterialSpecified.first
koo = KindOfObject.first
koos = KindOfObjectSpecified.first

# ToDo: Material overrides paths method for some reason. Change that back as such is highly unexpecting and bad. There also exists an after_create callback in Termlist model.
#m.paths   << Path.create_or_find_by(path: "/#{m.id}")
ms.paths  << Path.create_or_find_by(path: "/#{m.id}/#{ms.id}")
koo.paths << Path.create_or_find_by(path: "/#{m.id}/#{ms.id}/#{koo.id}")
undetermined_path = Path.create_or_find_by(path: "/#{m.id}/#{ms.id}/#{koo.id}/#{koos.id}")
koos.paths << undetermined_path

term_categories.each do |term_category|
  term_class = term_category.constantize
  term_class.first.paths << undetermined_path unless term_class.is_independent_of_paths
end