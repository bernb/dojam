  include FactoryBot::Syntax::Methods
  require_relative "test_data/dummy_museum_object_data.rb"
  require_relative "test_data/helper.rb"
  # This will guess the User class
FactoryBot.define do
  factory :random_museum_object, class: MuseumObject do
    inv_number {rand_inv_number}
    inv_numberdoa {rand_other_inv_number}
    storage_location {StorageLocation.find StorageLocation.ids.sample}
    inv_extension {rand(25)}
    amount {rand(100)}
    acquisition_deliverer_name {$dummy_data[:names].sample}
    termlist_acquisition_delivered_by {TermlistAcquisitionDeliveredBy.find TermlistAcquisitionDeliveredBy.ids.sample}
    acquisition_date {rand_date}
    site_number_mega {rand_number 1000, 10000}
    site_number_jadis {rand_number 1000, 10000}
    site_number_expedition {rand_number 1000, 10000}
    name_mega_jordan {$dummy_data[:locations].sample}
    name_expedition {$dummy_data[:locations].sample}
    coordinates_mega_lat {rand_coordinates}
    coordinates_mega_long {rand_coordinates}
    termlist_excavation_site_kind {TermlistExcavationSiteKind.find TermlistExcavationSiteKind.ids.sample}
    finding_context {$dummy_data[:short_texts].sample}
    finding_remarks {$dummy_data[:texts].sample}
    termlist_material_specifieds {[TermlistMaterialSpecified.find(TermlistMaterialSpecified.ids.sample)]}
    termlist_kind_of_object {rand_kind_of_object termlist_material_specifieds}
    termlist_kind_of_object_specified {rand_kind_of_object_specified termlist_kind_of_object}
  end
end


object = create(:random_museum_object)





