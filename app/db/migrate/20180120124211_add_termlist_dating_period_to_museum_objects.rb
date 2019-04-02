class AddTermlistDatingPeriodToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_dating_period, foreign_key: true
  end
end
