class CreateDecorationStyleMuseumObjects < ActiveRecord::Migration[5.2]
  def up
    create_table :decoration_style_museum_objects do |t|
      t.references :museum_object, foreign_key: true
      t.column :decoration_style_id, :integer, index: true
      t.foreign_key :termlists, column: :decoration_style_id

      t.timestamps
    end

    MuseumObject.all.each do |m|
      DecorationStyleMuseumObject.create museum_object_id: m.id, decoration_style_id: m.decoration_style.id
    end
  end

  def down 
    drop_table :decoration_style_museum_objects
  end
end
