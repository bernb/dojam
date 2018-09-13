class MuseumObjectDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

	def materials_decorated
		decorate_named_list self.materials
	end

	def material_specifieds_decorated
		decorate_named_list self.material_specifieds
	end

	def decorate_named_list list
		returnstring = ""
		if list.blank?
			# Do nothing
		elsif list.size == 1
			returnstring = list.first.name
		else
			list.each do |entry|
				returnstring += " #{entry.name},"
			end
		end
		return returnstring.chomp(",")
	end


	def max_length_decorated
		if self.max_length.blank? 
			"undetermined"
		else
			self.max_length
		end
	end

	def max_width_decorated
		if self.max_width.blank? 
			"undetermined"
		else
			self.max_width
		end
		j
	end

	def height_decorated
		if self.height.blank? 
			"undetermined"
		else
			self.height
		end
	end

	def opening_dm_decorated
		if self.opening_dm.blank? 
			"undetermined"
		else
			self.opening_dm
		end
	end
	
	def bottom_dm_decorated
		if self.bottom_dm.blank? 
			"undetermined"
		else
			self.bottom_dm
		end
	end

	def weight_in_gram_decorated
		if self.weight_in_gram.blank? 
			"undetermined"
		else
			self.weight_in_gram
		end
	end

	def coordinates_mega
		"#{self.coordinates_mega_lat} lat; #{self.coordinates_mega_long} long"
	end

	def dating_millennium
		if self.is_dating_millennium_unknown? || self.dating_millennium_begin.blank? || self.dating_millennium_begin.blank?
			return "unknown"
		else
			if self.dating_millennium_begin&.id == self.dating_millennium_end&.id
				return self.dating_millennium_begin&.name
			else
				return self.dating_millennium_begin&.name + " - " + self.dating_millennium_begin&.name
			end
		end
	end

	def dating_century
		if self.is_dating_century_unknown? || self.dating_century_begin.blank? || self.dating_century_begin.blank?
			return "unknown"
		else
			if self.dating_century_begin&.id == self.dating_century_end&.id
				return self.dating_century_begin&.name
			else
				return self.dating_century_begin.name + " - " + self.dating_century_begin.name
			end
		end
	end

	def dating_period_decorated
		if self.is_dating_period_unknown? || self.dating_period.blank?
			return "unknown"
		else
			return self.dating_period.name
		end
	end

	def full_inv_number
		return "" unless self.inv_number.present?
		if self.inv_extension.blank?
			self.inv_number
		else
			self.inv_number.to_s + "-" + self.inv_extension.to_s
		end
	end

	def name
		full_inv_number
	end

	def millennium_timespan
		if self.dating_millennium_begin.present? && self.dating_millennium_end.present?
			self.dating_millennium_begin.name + " - " + self.dating_millennium_end.name
		end
	end
  
  def dating_timespan
		if self.is_dating_timespan_unknown?
			return "unknown"
		end
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
