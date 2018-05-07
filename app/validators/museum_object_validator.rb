class MuseumObjectValidator < ActiveModel::Validator
  def validate record
    unless record.is_used
      return
    end
    if record.storage_location.nil?
      record.errors[:storage_location] << "Storage Location " + assoc_missing_string
    end
    if record.inv_number == ""
      record.errors[:storage_location] << "Inventory number " + assoc_missing_string
    end
  end
  
  private
  def assoc_missing_string
    "must be selected."
  end

end
