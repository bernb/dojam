id = ENV.fetch("id")

gold = TermlistMaterialSpecified.where(name: "gold")
                                 .where(termlist_material: TermlistMaterial
                                   .where(id: id))
                                 .first
                                 
gold_kind_of_objects = ["coin", "jewelry"]
gold_kind_of_objects.each do |kind|
  k = TermlistKindOfObject.create name: kind
  gold.termlist_kind_of_objects << k
end                                 

ENV["id"] = gold.id.to_s
require "#{Rails.root}/db/seeds/metal_gold_jewelry.rb"
