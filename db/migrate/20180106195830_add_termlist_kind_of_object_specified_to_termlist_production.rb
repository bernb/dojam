class AddTermlistKindOfObjectSpecifiedToTermlistProduction < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_productions, :termlist_kind_of_object_specified, foreign_key: true, index: {name: "termlist_kind_of_object_specified_id"}
  end
end
