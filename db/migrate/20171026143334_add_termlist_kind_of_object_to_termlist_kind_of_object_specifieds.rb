class AddTermlistKindOfObjectToTermlistKindOfObjectSpecifieds < ActiveRecord::Migration[5.0]
  def change
    add_reference :termlist_kind_of_object_specifieds, :termlist_kind_of_object, foreign_key: true, index: {name: 'index_kind_of_object_specifieds_on_kind_of_object_id'}
  end
end
