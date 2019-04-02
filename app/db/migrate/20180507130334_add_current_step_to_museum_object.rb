class AddCurrentStepToMuseumObject < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :current_step, :string
  end
end
