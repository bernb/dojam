class CreateJoinMuseumObjectDatingCenturies < ActiveRecord::Migration[5.0]
  def change
    create_table :join_museum_object_dating_centuries do |t|
      t.references :museum_object, foreign_key: true
      t.references :termlist_dating_century, foreign_key: true, index: {name: "index_join_mo_dating_centuries_on_dating_century_id"}

      t.timestamps
    end
  end
end
