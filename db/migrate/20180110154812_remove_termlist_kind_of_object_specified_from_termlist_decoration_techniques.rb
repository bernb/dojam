class RemoveTermlistKindOfObjectSpecifiedFromTermlistDecorationTechniques < ActiveRecord::Migration[5.0]
  def change
    remove_reference :termlist_decoration_techniques, :termlist_kind_of_object_specified, foreign_key: true
  end
end
