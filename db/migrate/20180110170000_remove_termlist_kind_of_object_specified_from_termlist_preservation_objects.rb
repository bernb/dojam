class RemoveTermlistKindOfObjectSpecifiedFromTermlistPreservationObjects < ActiveRecord::Migration[5.0]
  def change
    remove_reference :termlist_preservation_objects, :termlist_kind_of_object_specified, foreign_key: true
  end
end
