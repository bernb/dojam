class RemoveTermlistDecoColorFromTermlistKindOfObjectSpecifiedsDecorationColors < ActiveRecord::Migration[5.0]
  def change
    remove_reference :termlist_kind_of_object_specifieds_decoration_colors, :termlist_deco_color, foreign_key: true
  end
end
