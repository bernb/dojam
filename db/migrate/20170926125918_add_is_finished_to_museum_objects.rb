class AddIsFinishedToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :museum_objects, :is_finished, :boolean, default: false
  end
end
