class RemoveTermlistKindOfObjectSpecifiedFromTermlistDecorationColors < ActiveRecord::Migration[5.0]
  def change
    remove_reference :termlist_decoration_colors, :termlist_kind_of_object, foreign_key: true
  end
end
