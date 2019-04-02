class AddIsDatingPeriodUnknownToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :is_dating_period_unknown, :boolean
  end
end
