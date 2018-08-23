class RemoveDescriptionPreservationStateNameFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :description_preservation_state_name, :string
  end
end
