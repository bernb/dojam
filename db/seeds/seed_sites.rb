require "#{Rails.root}/db/seeds/data_sites.rb"

$excavation_site_names.each do |sitename|
  ExcavationSite.create name: sitename
end

$site_kinds.each do |category_name, kinds_array|
  category = TermlistExcavationSiteCategory.create name: category_name
  kinds_array.each do |site_kind_name|
    site_kind = TermlistExcavationSiteKind.create name: site_kind_name
    category.termlist_excavation_site_kinds << site_kind
  end
  site_kind = TermlistExcavationSiteKind.create name: "Unspecific/Unknown"
  category.termlist_excavation_site_kinds << site_kind
end
