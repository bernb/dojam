class AddTermlistPreservationStateToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_preservation_state, foreign_key: true
  end
end
