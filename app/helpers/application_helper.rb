module ApplicationHelper

def calc_progress_percentage state
  case state
    when 'museum'
      return 20
    when 'acquisition'
      return 40
    when 'provenance'
      return 60
    when 'confirm'
      return 100
    else
      return 0
  end
end

end
