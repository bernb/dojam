class CreateTermlistExcavationSiteKinds < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_excavation_site_kinds do |t|
      t.string :name

      t.timestamps
    end
  end
end
