class RemoveWrongColumnExcavationKindIdFromTermlists < ActiveRecord::Migration[5.2]
  def change
		remove_column :termlists, :excavation_site_kind_id
  end
end
