module ApplicationHelper

def calc_progress_percentage state
  case state
    when :step_museum
      return 14
    when :step_acquisition
      return 28
    when :step_provenance
      return 42
    when :step_material
      return 56
    when :step_inscription
      return 70
    when :step_authenticity_and_priority
      return 84
    when :step_confirm
      return 100
    else
      return 0
  end
end

end
