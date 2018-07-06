class MuseumObjectDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

	def show_acquisition_date
	end

	def full_inv_number
		return "" unless self.inv_number.present?
		if self.inv_extension.blank?
			self.inv_number
		else
			self.inv_number.to_s + "-" + self.inv_extension.to_s
		end
	end
  
  def dating_timespan
    timespan_begin_suffix = is_dating_timespan_begin_BC? ? " BC" : " AD"
    timespan_end_suffix = is_dating_timespan_end_BC? ? " BC" : " AD"
    if dating_timespan_begin.present? && dating_timespan_end.present?
      return dating_timespan_begin&.strftime("%Y") + timespan_begin_suffix + " - " + dating_timespan_end&.strftime("%Y") + timespan_end_suffix
    else
      return ""
    end
  end
	def needs_cleaning_yesno?
		self.needs_cleaning ? "Yes" : "No"
	end

	def needs_conservation_yesno?
		self.needs_conservation ? "Yes" : "No"
	end
end
