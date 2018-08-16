class CorrectionColumnNameMaterialMuseumObjectJoinTable < ActiveRecord::Migration[5.2]
  def change
		rename_column :material_museum_objects, :termlist_id, :material_id
  end
end
