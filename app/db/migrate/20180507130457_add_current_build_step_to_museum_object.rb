class AddCurrentBuildStepToMuseumObject < ActiveRecord::Migration[5.2]
  def change
    add_column :museum_objects, :current_build_step, :string, default: "initial"
  end
end
