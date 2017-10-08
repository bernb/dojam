class CreateTermlistKindOfObjectSpecifieds < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds do |t|
      t.string :name

      t.timestamps
    end
  end
end
