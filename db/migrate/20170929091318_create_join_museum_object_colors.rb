class CreateJoinMuseumObjectColors < ActiveRecord::Migration[5.0]
  def change
    create_table :join_museum_object_colors do |t|
      t.references :termlist_color, foreign_key: true
      t.references :museum_object, foreign_key: true

      t.timestamps
    end
  end
end
