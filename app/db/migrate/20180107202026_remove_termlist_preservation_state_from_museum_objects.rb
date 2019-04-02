class RemoveTermlistPreservationStateFromMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    remove_reference :museum_objects, :termlist_preservation_state, foreign_key: true
  end
end
