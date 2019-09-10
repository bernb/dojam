class LoanOut < ApplicationRecord
  belongs_to :museum_object
  def overdue?
    if return_date.blank? && planned_return < DateTime.now.to_date
      return true
    else
      return false
    end
  end
end
