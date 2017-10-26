class AddTermlistKindOfObjectToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_kind_of_object, foreign_key: true
  end
end
