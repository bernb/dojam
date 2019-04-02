class RemoveTermlistKindOfObjectSpecifiedFromTermlistDecorations < ActiveRecord::Migration[5.0]
  def change
    remove_reference :termlist_decorations, :termlist_kind_of_object_specified, foreign_key: true
  end
end
