class AddTermlistAuthenticityToMuseumObject < ActiveRecord::Migration[5.0]
  def change
    add_reference :museum_objects, :termlist_authenticity, foreign_key: true
  end
end
