class AddTermlistKindOfObjectSpecifiedToTermlistColor < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_colors, :termlist_kind_of_object_specified, foreign_key: true
  end
end
