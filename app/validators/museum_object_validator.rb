class MuseumObjectValidator < ActiveModel::Validator
  def validate record
    unless record.is_used
      return
    end
    if record.storage_location.nil?
      record.errors.add :storage_location, assoc_missing
    end
    if record.inv_number == ""
      record.errors.add :inventory_number, req_is_empty
    end
  end
  
  private
  def assoc_missing
    "must be selected."
  end
  
  def req_is_empty
    "must not be empty"
  end

end
