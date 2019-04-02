class AddIsDatingTimespanEndBcToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :is_dating_timespan_end_BC, :boolean
  end
end
