class SeedHelper

  def self.build_material_related_seed materialname, material_specifieds, kind_of_objects
    material = TermlistMaterial.create name: materialname
    
    # We build the seed recursive from material specified over kind of object
    # to kind of object specified
    # We assume identical entries for all specified materials, but kind of objects
    # have their own set of specified kinds
    material_specifieds.each do |material_specified|
      m = TermlistMaterialSpecified.create name: material_specified
      kind_of_objects.each do |kind_of_object|
        k = TermlistKindOfObject.new
        kind_of_object_name = nil
        # We assume a certain data structure with hashes if specified kind of object
        # is present it is given as a single hash with an array value
        # otherwise the name of the kind of object is given by a simple string
        if kind_of_object.class == Hash
          kind_of_object_name = kind_of_object.keys[0] # single key hashes
          kind_of_object[kind_of_object_name].each do |kind_specified|
            k_specified = TermlistKindOfObjectSpecified.create name: kind_specified
            k.termlist_kind_of_object_specifieds << k_specified
          end
        else
          kind_of_object_name = kind_of_object  
        end
        k.name = kind_of_object_name
        k.save!
        # always add undetermined entry
        k_specified = TermlistKindOfObjectSpecified.create name: "undetermined"
        k.termlist_kind_of_object_specifieds << k_specified
        m.termlist_kind_of_objects << k
      end # kind of object loop
      material.termlist_material_specifieds << m
    end # material loop
  
  end # method

end
