class CreateTermlistKindOfObjectSpecifiedsDecorations < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_decorations do |t|
      t.references :termlist_kind_of_object, foreign_key: true
      t.references :termlist_decoration, foreign_key: true

      t.timestamps
    end
  end
end
