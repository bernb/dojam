class CreateTermlistDecorationColors < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_decoration_colors do |t|
      t.string :name
      t.references :termlist_material_specified, foreign_key: true, index: {name: 'index_decoration_colors_on_material_specified_id'}

      t.timestamps
    end
  end
end
