class AddTermlistPreservationObjectToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_preservation_object, foreign_key: true
  end
end
