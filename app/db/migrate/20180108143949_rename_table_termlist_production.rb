class RenameTableTermlistProduction < ActiveRecord::Migration[5.0]
  def change
    rename_table :termlist_productions, :termlist_production_techniques
  end
end
