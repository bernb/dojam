class AddNeedsConservationToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :needs_conservation, :boolean
  end
end
