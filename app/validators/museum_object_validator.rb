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
      when "initial", "step_museum"
        validate_step_museum_for record
      when "step_acquisition"
        validate_step_acquisition_for record
      when "step_provenance"
        validate_step_provenance_for record
      when "step_material"
        validate_step_material_for record
      when "step_material_specified"
        validate_step_material_specified_for record
      when "step_kind_of_object"
        validate_step_kind_of_object_for record
      when "step_kind_of_object_specified"
        validate_step_kind_of_object_specified_for record
      when "step_production"
        validate_step_production_for record
      when "step_color"
        validate_step_color_for record
      when "step_decoration"
        validate_step_decoration_for record
      when "step_inscription"
        validate_step_inscription_for record
      when "step_measurements"
        validate_step_measurements_for record
      when "step_authenticity"
        validate_step_authenticity_for record
      when "step_preservation"
        validate_step_authenticity_for record
      when "step_conservation"
        validate_step_conservation_for record
      else
        can_not_validate record
    end
    
  end
  
  private
  
  def validate_step_museum_for record
    check_assoc_exists record, :storage_location, record.storage_location
    check_not_empty record, :inventory_number, record.inv_number
    check_not_empty record, :inventory_extension, record.inv_extension
    check_is_number record, :inventory_extension, record.read_attribute_before_type_cast(:inv_extension)
    check_not_empty record, :amount, record.amount
  end
  
  def validate_step_acquisition_for record
    check_assoc_exists record, :kind_of_acquisition, record.termlist_acquisition_kind
    check_assoc_exists record, :delivered_by, record.termlist_acquisition_delivered_by
    check_not_empty record, :deliverer_name, record.acquisition_deliverer_name
    check_not_empty record, :date_of_acquisition, record.acquisition_date
    check_not_empty record, :number_of_acquisition_document, record.acquisition_document_number
  end
  
  def validate_step_provenance_for record
  
  end
  
  def validate_step_material_for record
    # This is done in controller as material itself is not saved in db
  end
  
  def validate_step_material_specified_for record
    check_assoc_exists record, :material_specified, record.termlist_material_specifieds
  end
  
  def validate_step_kind_of_object_for record
    check_assoc_exists record, :kind_of_object, record.termlist_kind_of_object
  end
  
  def validate_step_kind_of_object_specified_for record
    check_assoc_exists record, :kind_of_object_specified, record.termlist_kind_of_object_specified
  end
  
  def validate_step_production_for record
    check_assoc_exists record, :production_technique, record.termlist_production_technique
  end
  
  def validate_step_color_for record
    check_assoc_exists record, :color, record.termlist_colors
  end
  
  def validate_step_decoration_for record
    check_assoc_exists record, :decoration_technique, record.termlist_decoration
    check_assoc_exists record, :decoration_color, record.termlist_decoration_color
  end
  
  def validate_step_inscription_for record
    check_assoc_exists record, :letters_of_inscription, record.termlist_inscription_letter
    check_assoc_exists record, :language_of_inscription, record.termlist_inscription_language
    check_not_empty record, :text_of_inscription, record.inscription_text
    check_not_empty record, :text_of_inscription, record.inscription_text
    check_not_empty record, :translation_of_inscription, record.inscription_translation
  end
  
  def validate_step_measurements_for record
  
  end
  
  def validate_step_authenticity_for record
    check_assoc_exists record, :authenticity, record.termlist_authenticity
    check_assoc_exists record, :priority, record.priority
    check_not_empty record, :priority_determined_by, record.priority_determined_by
  end
  
  def validate_step_authenticity_for record
    check_assoc_exists record, :preservation_of_material, record.termlist_preservation_material
    check_assoc_exists record, :preservation_of_object, record.termlist_preservation_object
  end
  
  def validate_step_conservation_for record
  
  end
  
  
  
  
  
  def can_not_validate record
    record.errors.add :critical, "error: Can not determine current step for validation."
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
    # nil if belongs_to missing
    # blank if has_many missing
    if value.nil? || value.blank?
      record.errors.add field_name, "must be selected."
    end

  end
  

end
