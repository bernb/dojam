class CreateTermlistKindOfObjectSpecifiedsColors < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_colors do |t|
      t.references :termlist_color, foreign_key: true, index: {name: "index_kind_of_object_specifieds_colors_on_color_id"}
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_kind_of_object_spec_colors_on_kind_of_object_spec_id"}

      t.timestamps
    end
  end
end
