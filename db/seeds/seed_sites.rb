require "#{Rails.root}/db/seeds/data_sites.rb"

$excavation_site_names.each do |sitename|
  ExcavationSite.create name: sitename
end
