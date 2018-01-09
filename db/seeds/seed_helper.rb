class SeedHelper

  # ToDo: Optimize as this is way too slow
  def self.build_material_related_seed material_hash
  
    materialname = material_hash[:material_name]
    material_specifieds = material_hash[:material_specifieds]
    kind_of_objects = material_hash[:kind_of_objects]
    material = TermlistMaterial.create name: materialname
    
    ### Pre-Build all properties except above defined ones ###
    production_techniques = material_hash[:production_techniques]
    
    @production_technique_objects = []
    production_techniques.each do |production_technique|
      p = TermlistProductionTechnique.create name: production_technique
      @production_technique_objects << p
    end
    
    
    # ToDo: Refactor and split into smaller units
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
        add_all_properties k.termlist_kind_of_object_specifieds
        m.termlist_kind_of_objects << k
      end # kind of object loop
      material.termlist_material_specifieds << m
    end # material loop
  
  end # method
  
  private
  
  def self.add_all_properties kind_of_object_specifieds # Parameter is a valid active records object
    kind_of_object_specifieds.each do |kind_of_object_specified|
      add_production_techniques kind_of_object_specified
    end
  end
  
  def self.add_production_techniques kind_of_object_specified
    @production_technique_objects.each do |production_technique|
      kind_of_object_specified.termlist_production_techniques << production_technique
    end
  end
  
end
