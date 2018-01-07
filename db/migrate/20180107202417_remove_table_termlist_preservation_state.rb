class RemoveTableTermlistPreservationState < ActiveRecord::Migration[5.0]
  def change
    drop_table :termlist_preservation_states
  end
end
