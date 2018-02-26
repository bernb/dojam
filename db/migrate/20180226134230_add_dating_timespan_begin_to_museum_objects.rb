class AddDatingTimespanBeginToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :dating_timespan_begin, :date
  end
end
