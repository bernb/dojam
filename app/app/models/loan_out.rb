class LoanOut < ApplicationRecord
  belongs_to :museum_object
  scope :museum, ->(given_museum) {joins(museum_object:
                            {storage_location:
                               {storage: :museum}})
                      .where(museum_object:
                               {storage_locations:
                                  {storages:
                                     {museum: given_museum}}})}

  def overdue?
    if return_date.blank? && planned_return < DateTime.now.to_date
      return true
    else
      return false
    end
  end
end
