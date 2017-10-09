module ApplicationHelper

def calc_progress_percentage state
  case state
    when :step_museum
      return 5
    when :step_acquisition
      return 10
    when :step_provenance
      return 15
    when :step_material
      return 20
    when :step_material
      return 35
    when :step_material_specified
      return 40
    when :step_kind_of_object
      return 45
    when :step_kind_of_object_specified
      return 50
    when :step_production
      return  55
    when :step_color
      return 60
    when :step_decoration
      return  65
    when :step_inscription
      return 70
    when :step_measurements
      return 75
    when :step_authenticity
      return 80
    when :step_confirm
      return 100
    else
      return 0
  end
end

end
