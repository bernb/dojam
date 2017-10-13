class AddTermlistDatingMillenniumToMusemObjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :musem_objects, :termlist_dating_millennium, foreign_key: true
  end
end
