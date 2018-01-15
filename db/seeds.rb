require "#{Rails.root}/db/seeds/seed_museums.rb"
require "#{Rails.root}/db/seeds/seed_materials.rb"
require "#{Rails.root}/db/seeds/seed_storages.rb"
require "#{Rails.root}/db/seeds/seed_sites.rb"
require "#{Rails.root}/db/seeds/seed_other_termlists.rb"

 
 
=begin                    

termlist_preservations = ["complete", "fragmentary"]
termlist_preservations.each do |preservation|
  TermlistPreservation.create name: preservation
end

termlist_conservations = ["no", "yes", "partially", "cleaned", "consolidated", "needed", "unknown"]
termlist_conservations.each do |conservation|
  TermlistConservation.create name: conservation
end

termlist_dating_period = ["Palaeolithic", "Mesolithic", "Neolithic", "Chalcolithic",
                          "Bronze Age", "Early Bronze Age", "Middle Bronze Age",
                          "Late Bronze Age", "Iron Age", "Early Iron Age",
                          "Late Iron Age", "Hellenistic", "Nabataean", "Roman",
                          "Byzantine", "Umayyad", "Abbasid", "Ayyubid", "Mamluk",
                          "Ottoman", "Modern"]

termlist_dating_period.each do |period|
  TermlistDatingPeriod.create name: period
end


termlist_dating_millennium = [ "10th mill. BC", "9th mill. BC", "8th mill. BC", 
                               "7th mill. BC", "6th mill. BC", "5th mill. BC",
                               "4th mill. BC", "3rd mill. BC", "2nd mill. BC",
                               "1st mill. BC", "1st mill. AD", "2nd mill. AD"]

termlist_dating_millennium.each do |millennium|
  TermlistDatingMillennium.create name: millennium
end

=end
