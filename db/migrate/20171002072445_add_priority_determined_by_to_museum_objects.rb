class AddPriorityDeterminedByToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :priority_determined_by, :string
  end
end
