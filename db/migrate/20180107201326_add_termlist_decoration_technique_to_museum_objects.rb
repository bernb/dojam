class AddTermlistDecorationTechniqueToMuseumObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_decoration_technique, foreign_key: true
  end
end
