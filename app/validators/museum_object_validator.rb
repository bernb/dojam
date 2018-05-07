# From the docs:
# Note that the validator will be initialized only once
# for the whole application life cycle, and not on each
# validation run, so be careful about using instance variables inside it.

class MuseumObjectValidator < ActiveModel::Validator
  def validate record
    unless record.is_used
      return
    end
    step_to_validate = record.current_build_step
    
    case step_to_validate
      when "initial" || "step_museum"
        validate_step_museum_for record
      else
        can_not_validate
    end
    
  end
  
  private
  
  def validate_step_museum_for record
    check_assoc_exists record, :storage_location, record.storage_location
    check_not_empty record, :inventory_number, record.inv_number
    check_not_empty record, :inventory_extension, record.inv_extension
    check_is_number record, :inventory_extension, record.read_attribute_before_type_cast(:inv_extension)
    #check_not_empty record, :other_inventory_number, record.inv_numberdoa
    check_not_empty record, :amount, record.amount
  end
  
  
  
  
  
  
  
  def can_not_validate record
    record.errors.add :base, "Critical: Can not determine current step for validation."
  end
  
  def check_not_empty record, field_name, value
    if value.nil? || value == ""
      record.errors.add field_name, "must not be empty."
    end
  end
  
  def check_is_number record, field_name, value
    if value.present? && /\D/.match?(value.to_s)
      record.errors.add field_name, "must be a number."
    end
  end
  
  def check_assoc_exists record, field_name, value
    if value.nil?
      record.errors.add field_name, "must be selected."
    end
  end
  

end
