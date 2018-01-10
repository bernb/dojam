class SeedHelper

  # ToDo: Optimize as this is way too slow
  # If more properties gets added, consider using metaprogramming to recursive add all propertiy data
  def self.build_material_related_seed material_hash
  
    materialname = material_hash[:material_name]
    material_specifieds = material_hash[:material_specifieds]
    kind_of_objects = material_hash[:kind_of_objects]
    material = TermlistMaterial.create name: materialname
    
    ### Pre-Build all properties except above defined ones ###
    production_techniques = material_hash[:production_techniques]
    decorations = material_hash[:decorations]
    colors = material_hash[:colors]
    decoration_colors = material_hash[:decoration_colors]
    decoration_techniques = material_hash[:decoration_techniques]
    
    @decoration_techniques = []
    decoration_techniques.each do |decoration_technique|
      d = TermlistDecorationTechnique.where(name: decoration_technique).first
      d ||= TermlistDecorationTechnique.create name: decoration_technique
      @decoration_techniques << d
    end
    
    @decoration_colors = []
    decoration_colors.each do |decoration_color|
      d = TermlistDecorationColor.where(name: decoration_color).first
      d ||= TermlistDecorationColor.create name: decoration_color
      @decoration_colors << d
    end
    
    @color_objects = []
    colors.each do |color|
      c = TermlistColor.where(name: color).first
      c ||= TermlistColor.create name: color
      @color_objects << c
    end
    
    @decoration_objects = []
    decorations.each do |decoration|
      d = TermlistDecoration.where(name: decoration).first
      d ||= TermlistDecoration.create name: decoration
      @decoration_objects << d
    end
    
    @production_technique_objects = []
    production_techniques.each do |production_technique|
      p = TermlistProductionTechnique.where(name: production_technique).first
      p ||= TermlistProductionTechnique.create name: production_technique
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
      add_decorations kind_of_object_specified
      add_colors kind_of_object_specified
      add_decoration_colors kind_of_object_specified
      add_decoration_techniques kind_of_object_specified
    end
  end
  
  def self.add_decoration_techniques kind_of_object_specified
    @decoration_techniques.each do |decoration_technique|
      kind_of_object_specified.termlist_decoration_techniques << decoration_technique
    end
  end
  
  def self.add_decoration_colors kind_of_object_specified
    @decoration_colors.each do |decoration_color|
      kind_of_object_specified.termlist_decoration_colors << decoration_color
    end
  end
  
  def self.add_colors kind_of_object_specified
    @color_objects.each do |color|
      kind_of_object_specified.termlist_colors << color
    end
  end
  
  def self.add_decorations kind_of_object_specified
    @decoration_objects.each do |decoration|
      kind_of_object_specified.termlist_decorations << decoration
    end
  end
  
  def self.add_production_techniques kind_of_object_specified
    @production_technique_objects.each do |production_technique|
      kind_of_object_specified.termlist_production_techniques << production_technique
    end
  end
  
end
