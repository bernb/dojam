class CorrectionColumnNameMaterialSpecifiedMuseumObject < ActiveRecord::Migration[5.2]
  def change
		# First name the index, otherwise rails will rename automatically which results in too long index name
		rename_index :material_specified_museum_objects, "index_material_specified_museum_objects_on_termlist_id", "index_ms_museum_objects_on_ms_id"
		rename_column :material_specified_museum_objects, :termlist_id, :material_specified_id
  end
end
