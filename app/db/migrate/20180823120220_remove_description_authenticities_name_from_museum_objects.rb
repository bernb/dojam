class RemoveDescriptionAuthenticitiesNameFromMuseumObjects < ActiveRecord::Migration[5.2]
  def change
		remove_column :museum_objects, :description_authenticities_name
  end
end
