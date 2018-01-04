id = ENV.fetch("id")

bronze = TermlistMaterialSpecified.where(name: "bronze")
                                 .where(termlist_material: TermlistMaterial
                                   .where(id: id))
                                 .first

bronze_kind_of_object = ["applicator", "arrowhead", "ax", "balance weight", "bell", "brazier", "cannon", "chain armor", 
                         "coin", "cosmetic spatula", "cosmetic spoon", "dagger", "jewelry", "kohl stick", "kohl tube", "mirror", 
                         "nail", "needle", "pin", "spearhead", "sculpture", "sword", "vessel"]
                         
bronze = TermlistMaterialSpecified.where(name: "bronze").first                         
bronze_kind_of_object.each do |kind|
  k = TermlistKindOfObject.create name: kind
  bronze.termlist_kind_of_objects << k
end 


ENV["id"] = bronze.id.to_s
require "#{Rails.root}/db/seeds/metal_bronze_jewelry.rb"
ENV["id"] = bronze.id.to_s
require "#{Rails.root}/db/seeds/metal_bronze_sculpture.rb"
ENV["id"] = bronze.id.to_s
require "#{Rails.root}/db/seeds/metal_bronze_vessel.rb"
