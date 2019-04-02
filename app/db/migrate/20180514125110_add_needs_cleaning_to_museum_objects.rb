class AddNeedsCleaningToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :needs_cleaning, :boolean
  end
end
