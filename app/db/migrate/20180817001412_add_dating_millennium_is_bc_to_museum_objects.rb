class AddDatingMillenniumIsBcToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		add_column :museum_objects, :is_dating_millennium_begin_bc, :boolean
		add_column :museum_objects, :is_dating_millennium_end_bc, :boolean
  end
end
