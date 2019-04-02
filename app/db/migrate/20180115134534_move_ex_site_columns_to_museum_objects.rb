class MoveExSiteColumnsToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
  remove_column :excavation_sites, :name_mega_jordan
  remove_column :excavation_sites, :name_expedition
  remove_column :excavation_sites, :site_number_mega
  remove_column :excavation_sites, :site_number_jadis
  remove_column :excavation_sites, :site_number_expedition
  remove_column :excavation_sites, :coordinates_mega
  remove_column :excavation_sites, :excavation_site_kind_id
  
  add_column :museum_objects, :name_mega_jordan, :string
  add_column :museum_objects, :name_expedition, :string
  add_column :museum_objects, :site_number_mega, :string
  add_column :museum_objects, :site_number_jadis, :string
  add_column :museum_objects, :site_number_expedition, :string
  add_column :museum_objects, :coordinates_mega, :string
  add_reference :museum_objects, :excavation_site_kind, index: true
  end
end
