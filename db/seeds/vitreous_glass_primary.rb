id = ENV.fetch("id")

primary = TermlistKindOfObject.where(name: "primary product/waste")
                              .where(termlist_material_specified: TermlistMaterialSpecified
                                .where(id: id))
                              .first
vessel_kind_specifieds = ["drop", "granulate", "ingot", "lump", "waste", "undetermined"]                            
vessel_kind_specifieds.each do |kind|
  kind_of_object = TermlistKindOfObjectSpecified.create name: kind
  primary.termlist_kind_of_object_specifieds << kind_of_object
end
