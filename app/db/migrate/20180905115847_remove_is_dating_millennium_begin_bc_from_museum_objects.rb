class RemoveIsDatingMillenniumBeginBcFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		remove_column :museum_objects, :is_dating_millennium_begin_bc
  end
end
