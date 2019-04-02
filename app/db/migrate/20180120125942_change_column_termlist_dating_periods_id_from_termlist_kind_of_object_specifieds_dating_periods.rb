class ChangeColumnTermlistDatingPeriodsIdFromTermlistKindOfObjectSpecifiedsDatingPeriods < ActiveRecord::Migration[5.0]
  def change
  rename_column :termlist_kind_of_object_specifieds_dating_periods, :termlist_dating_periods_id, :termlist_dating_period_id
  end
end
