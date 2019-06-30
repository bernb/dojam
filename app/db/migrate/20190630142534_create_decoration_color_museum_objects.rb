class CreateDecorationColorMuseumObjects < ActiveRecord::Migration[5.2]
  def up
    create_table :decoration_color_museum_objects do |t|
      t.references :museum_object, foreign_key: true
      t.column :decoration_color_id, :integer, index: true
      t.foreign_key :termlists, column: :decoration_color_id

      t.timestamps
    end

    MuseumObject.all.each do |m|
      DecorationColorMuseumObject.create museum_object_id: m.id, decoration_color_id: m.decoration_color.id
    end
  end

  def down 
    drop_table :decoration_color_museum_objects
  end
end
