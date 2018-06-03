class AddTermlistPriorityToMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :museum_objects, :termlist_priority, foreign_key: true
  end
end
