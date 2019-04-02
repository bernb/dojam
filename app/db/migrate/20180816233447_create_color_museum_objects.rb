class CreateColorMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :color_museum_objects do |t|
			t.column :color, :integer
      t.references :termlist, foreign_key: true, column: :color
      t.references :museum_object, foreign_key: true

      t.timestamps
    end
  end
end
