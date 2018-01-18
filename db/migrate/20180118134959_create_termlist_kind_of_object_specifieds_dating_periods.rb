class CreateTermlistKindOfObjectSpecifiedsDatingPeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :termlist_kind_of_object_specifieds_dating_periods do |t|
      t.references :termlist_kind_of_object_specified, foreign_key: true, index: {name: "index_koos_dating_periods_on_koos_id"}
      t.references :termlist_dating_periods, foreign_key: true, index: {name: "index_koos_dating_periods_on_termlist_dating_periods_id"}

      t.timestamps
    end
  end
end
