class AddTermlistKindOfObjectSpecifiedToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_kind_of_object_specified, foreign_key: true
  end
end
