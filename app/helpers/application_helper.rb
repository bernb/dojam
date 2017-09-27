module ApplicationHelper

def calc_progress_percentage state
  case state
    when :step_museum
      return 20
    when :step_acquisition
      return 40
    when :step_provenance
      return 60
    when :step_confirm
      return 100
    else
      return 0
  end
end

end
