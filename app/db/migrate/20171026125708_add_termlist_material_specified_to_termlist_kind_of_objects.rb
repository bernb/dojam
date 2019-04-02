class AddTermlistMaterialSpecifiedToTermlistKindOfObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_kind_of_objects, :termlist_material_specified, foreign_key: true, index: {name: 'index_kind_of_objects_on_material_specified_id'}
  end
end
