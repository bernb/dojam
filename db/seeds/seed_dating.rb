require "#{Rails.root}/db/seeds/data/data_dating.rb"
require "#{Rails.root}/db/seeds/seed_helper.rb"

SeedHelper.build_dating_related_seed $data_dating
