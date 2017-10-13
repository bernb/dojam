class AddTermlistDatingMillenniumToMusemObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_dating_millennium, foreign_key: true
  end
end
