class CorrectionColumnNameColorIdJoinTable < ActiveRecord::Migration[5.2]
  def change
		rename_column :color_museum_objects, :color, :color_id
  end
end
