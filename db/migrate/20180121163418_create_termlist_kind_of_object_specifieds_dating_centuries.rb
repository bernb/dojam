class CreateTermlistKindOfObjectSpecifiedsDatingCenturies < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_dating_centuries do |t|
      t.references :termlist_dating_century, foreign_key: true, index: {name: "index_tkoos_dating_centuries_on_dating_century_id"}
      t.references :termlist_kind_of_object_specifieds, foreign_key: true, index: {name: "index_koos_dating_centuries_on_koos_id"}

      t.timestamps
    end
  end
end
