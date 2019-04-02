namespace :db do
	namespace :seed do
		desc "Only seed material related data"
		# Depends on rails environment
		task materials: :environment do
			require "#{Rails.root}/db/seeds/material.rb"
		end

		desc "Only seed general termlists (excludes material related ones)"
		task general: :environment do
			require "#{Rails.root}/db/seeds/general.rb"
		end
	end
end
