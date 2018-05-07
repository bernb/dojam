class RemoveCurrentStepFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :museum_objects, :current_step, :string
  end
end
