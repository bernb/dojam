class MakeForeignKeysUniqueForMaterialSpecifiedsKooSpecs < ActiveRecord::Migration[5.2]
  def change
		add_index :material_specifieds_koo_specs, [:termlist_material_specified_id, :termlist_kind_of_object_specified_id], unique: true, name: "index_ms_koo_specs_on_ms_id_and_koos_id"
  end
end
