class AddTermlistKindOfObjectSpecifiedToTermlistDecoration < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_decorations, :termlist_kind_of_object_specified, foreign_key: true, index: {name: "decorations_on_kind_of_object_specified_id"}
  end
end
