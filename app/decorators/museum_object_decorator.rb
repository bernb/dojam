class MuseumObjectDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all
  
  def dating_timespan
    timespan_begin_suffix = is_dating_timespan_begin_BC? ? " BC" : " AD"
    timespan_end_suffix = is_dating_timespan_end_BC? ? " BC" : " AD"
    if dating_timespan_begin.present? && dating_timespan_end.present?
      return dating_timespan_begin&.strftime("%Y") + timespan_begin_suffix + " - " + dating_timespan_end&.strftime("%Y") + timespan_end_suffix
    else
      return ""
    end
  end
end
