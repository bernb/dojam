class SeedHelper

  # ToDo: Optimize as this is way too slow
  # If more properties gets added, consider using metaprogramming to recursive add all propertiy data
  def self.build_material_related_seed material_hash
  
    @debug_index = 0
  
    materialname = material_hash[:material_name]
    puts "Importing #{materialname}"
    material_specifieds = material_hash[:material_specifieds]
    kind_of_objects = material_hash[:kind_of_objects]
    material = TermlistMaterial.new name: materialname
    
    ### Pre-Build all properties except above defined ones ###
    production_techniques = material_hash[:production_techniques]
    decorations = material_hash[:decorations]
    colors = material_hash[:colors]
    decoration_colors = material_hash[:decoration_colors]
    decoration_techniques = material_hash[:decoration_techniques]
    preservation_materials = material_hash[:preservation_materials]
    preservation_objects = material_hash[:preservation_objects]
    inscription_languages = material_hash[:inscription_languages]
    inscription_letters = material_hash[:inscription_letters]
    
    
    @inscription_letter_ids =  []
    inscription_letters.each do |inscription_letter|
      l = TermlistInscriptionLetter.where(name: inscription_letter).first
      l ||= TermlistInscriptionLetter.create name: inscription_letter
      @inscription_letter_ids << l.id
    end
    
    @inscription_language_ids =  []
    inscription_languages.each do |inscription_language|
      i = TermlistInscriptionLanguage.where(name: inscription_language).first
      i ||= TermlistInscriptionLanguage.create name: inscription_language
      @inscription_language_ids << i.id
    end
    
    @preservation_object_ids = []
    preservation_objects.each do |preservation_object|
      p = TermlistPreservationObject.where(name: preservation_object).first
      p ||= TermlistPreservationObject.create name: preservation_object
      @preservation_object_ids << p.id
    end
    
    @preservation_material_ids = []
    preservation_materials.each do |preservation_material|
      p = TermlistPreservationMaterial.where(name: preservation_material).first
      p ||= TermlistPreservationMaterial.create name: preservation_material
      @preservation_material_ids << p.id
    end
    
    @decoration_technique_ids = []
    decoration_techniques.each do |decoration_technique|
      d = TermlistDecorationTechnique.where(name: decoration_technique).first
      d ||= TermlistDecorationTechnique.create name: decoration_technique
      @decoration_technique_ids << d.id
    end
    
    @decoration_color_ids = []
    decoration_colors.each do |decoration_color|
      d = TermlistDecorationColor.where(name: decoration_color).first
      d ||= TermlistDecorationColor.create name: decoration_color
      @decoration_color_ids << d.id
    end
    
    @color_object_ids = []
    colors.each do |color|
      c = TermlistColor.where(name: color).first
      c ||= TermlistColor.create name: color
      @color_object_ids << c.id
    end
    
    @decoration_object_ids = []
    decorations.each do |decoration|
      d = TermlistDecoration.where(name: decoration).first
      d ||= TermlistDecoration.create name: decoration
      @decoration_object_ids << d.id
    end
    
    @production_technique_object_ids = []
    production_techniques.each do |production_technique|
      p = TermlistProductionTechnique.where(name: production_technique).first
      p ||= TermlistProductionTechnique.create name: production_technique
      @production_technique_object_ids << p.id
    end
    
    kind_of_object_specified_ids = []
    # ToDo: Refactor and split into smaller units
    # We build the seed recursive from material specified over kind of object
    # to kind of object specified
    # We assume identical entries for all specified materials, but kind of objects
    # have their own set of specified kinds
    material_specifieds.each do |material_specified|
      m = material.termlist_material_specifieds.build name: material_specified
      kind_of_objects.each do |kind_of_object|
        k = m.termlist_kind_of_objects.build
        kind_of_object_name = nil
        # We assume a certain data structure with hashes if specified kind of object
        # is present it is given as a single hash with an array value
        # otherwise the name of the kind of object is given by a simple string
        if kind_of_object.class == Hash
          kind_of_object_name = kind_of_object.keys[0] # single key hashes
          kind_of_object[kind_of_object_name].each do |kind_specified|
            k_specified = k.termlist_kind_of_object_specifieds.build name: kind_specified
          end
        else
          kind_of_object_name = kind_of_object  
        end
        k.name = kind_of_object_name
        # always add undetermined entry
        k.termlist_kind_of_object_specifieds.build name: "undetermined"
      end # kind of object loop
    end # material loop
    
    material.save # saves recursive efficiently by default
    kind_of_object_specified_ids = material.termlist_kind_of_object_specifieds.ids  
    generate_join_tables kind_of_object_specified_ids
    
  end # method
  
  private
  
  def self.generate_join_tables kind_of_object_specified_ids
    execute_transaction kind_of_object_specified_ids, 
                       @production_technique_object_ids, 
                        "termlist_kind_of_object_specifieds_production_techniques", 
                        "termlist_production_technique_id"
                        
    execute_transaction kind_of_object_specified_ids, 
                        @decoration_object_ids, 
                        "termlist_kind_of_object_specifieds_decorations", 
                        "termlist_decoration_id"
  
    execute_transaction kind_of_object_specified_ids, 
                        @color_object_ids, 
                        "termlist_kind_of_object_specifieds_colors", 
                        "termlist_color_id"
                        
    execute_transaction kind_of_object_specified_ids, 
                        @decoration_color_ids, 
                        "termlist_kind_of_object_specifieds_decoration_colors", 
                        "termlist_decoration_color_id"
    
    execute_transaction kind_of_object_specified_ids, 
                        @decoration_technique_ids, 
                        "termlist_kind_of_object_specifieds_decoration_techniques", 
                        "termlist_decoration_technique_id"
                        
    execute_transaction kind_of_object_specified_ids, 
                        @preservation_material_ids, 
                        "termlist_kind_of_object_specifieds_preservation_materials", 
                        "termlist_preservation_material_id"
                        
    execute_transaction kind_of_object_specified_ids, 
                        @preservation_object_ids, 
                        "termlist_kind_of_object_specifieds_preservation_objects", 
                        "termlist_preservation_object_id"
                        
    execute_transaction kind_of_object_specified_ids, 
                        @inscription_language_ids, 
                        "termlist_kind_of_object_specifieds_inscription_languages", 
                        "termlist_inscription_language_id"
                        
    execute_transaction kind_of_object_specified_ids, 
                        @inscription_letter_ids, 
                        "termlist_kind_of_object_specifieds_inscription_letters", 
                        "termlist_inscription_letter_id"
  end
  
  def self.execute_transaction kind_of_object_specified_ids, property_ids, join_table_name, property_column_name
    if property_ids.empty?
      puts "  Warning: No entries to insert for #{property_column_name}"
      return
    end
    koos_ids = kind_of_object_specified_ids.map{|e| "(#{e})"}.join(',') # Generate format "(1), (2), (3),..." as needed for sql insert
    timestamp = DateTime.current.to_s
    pres_object_ids = property_ids.map{|e| "(#{e}, '#{timestamp}', '#{timestamp}')"}.join(',')
    # Create a tmp table and use cross join = cartesian product on it
    sql_query = 
    "
      DROP TABLE IF EXISTS koos_temp;
      DROP TABLE IF EXISTS props_temp;
      CREATE TABLE koos_temp (koos_ids INT);
      CREATE TABLE props_temp (prop_ids INT, created_at timestamp, updated_at timestamp);
      
      INSERT INTO koos_temp VALUES #{koos_ids};
      
      INSERT INTO props_temp VALUES #{pres_object_ids};
      INSERT INTO #{join_table_name} (termlist_kind_of_object_specified_id, #{property_column_name}, created_at, updated_at) 
        SELECT koos_ids, prop_ids, created_at, updated_at FROM koos_temp CROSS JOIN props_temp;

      DROP TABLE koos_temp;
      DROP TABLE props_temp;
    "
    ActiveRecord::Base.transaction do # We do not want the temp table to stick around
      ActiveRecord::Base.connection.execute(sql_query)
    end
  end
  
end
