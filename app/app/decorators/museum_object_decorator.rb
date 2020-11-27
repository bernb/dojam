class MuseumObjectDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def color_list
    self.decorate_named_list self.colors
  end

  def measurements
    measurement = ""
    postfix = ""
    if self.max_width.present?
      measurement << self.max_width.to_i.to_s
      postfix << I18n.t('width')
    end

    if self.max_length.present?
      if measurement.present?
        measurement << "x"
        postfix << "x"
      end
      measurement << self.max_length.to_i.to_s
      postfix << I18n.t('length')
    end

    if self.height.present?
      if measurement.present?
        measurement << "x"
        postfix << "x"
      end
      measurement << self.height.to_i.to_s
      postfix << I18n.t('height')
    end

    if measurement.present?
      measurement << " cm" 
    else
      measurement = I18n.t('undetermined')
    end
  end

  def basic_object_properties
    properties = ""
    material_unknown = false
    kind_unknown = false

    if self.main_material_specified.present? && self.main_material_specified.name != I18n.t('undetermined')
      properties << self.main_material_specified.name
    elsif self.main_material.present? && self.main_material.name != I18n.t('undetermined')
      properties << self.main_material.name
    else
     material_unknown = true 
    end

    if self.kind_of_object_specified.present? && self.kind_of_object_specified.name != I18n.t('undetermined')
      properties << " " + self.kind_of_object_specified.name
    elsif self.kind_of_object.present? && self.kind_of_object.name != I18n.t('undetermined')
      properties << " " + self.kind_of_object.name
    else
      kind_unknown = true
    end

    if material_unknown
      properties << ", main material undetermined"
    end

    if kind_unknown
      properties << ", kind of object undetermined"
    end

    if material_unknown && kind_unknown
      properties = I18n.t('main_material_and_kind_of_object_undetermined')
    end

    return properties
  end

	def main_material_with_specified
		return I18n.t('undetermined') + ' (' + I18n.t('undetermined') + ')' unless main_path.present?
			material_name = main_path.objects[0].name
			material_specified_name = main_path.objects[1]&.name || I18n.t('undetermined')
			result = material_name + " (" + material_specified_name + ")"
		return result
	end

	def secondary_materials_with_specifieds
		result = []
		secondary_paths.each do |path|
			material_name = path.objects[0].name
			material_specified_name = path.objects[1]&.name || I18n.t('undetermined')
			element = material_name + "(" + material_specified_name + ")"
			result << element
		end
		if result.empty?
			result << I18n.t('undetermined') + ' (' + I18n.t('undetermined') + ')'
		end
		return result
	end

	def materials_decorated
		decorate_named_list self.materials
	end

	def material_specifieds_decorated
		decorate_named_list self.material_specifieds
	end

	def materials_with_specifieds
		result = []
		[self.main_path].push(self.paths.to_a).reject(&:blank?).flatten.each do |path|
			material_name = path.objects[0].name
			material_specified_name = path.objects[1]&.name || I18n.t('undetermined')
			element = material_name + "(" + material_specified_name + ")"
			result << element
		end
		if result.empty?
			result << I18n.t('undetermined') + ' (' + I18n.t('undetermined') + ')'
		end
		return result
	end

	def decorate_named_list list
		returnstring = ""
		if list.blank?
			returnstring = I18n.t('undetermined')
		elsif list.size == 1
			returnstring = list.first.name
		else
			list.each do |entry|
				returnstring += " #{entry.name},"
			end
		end
		return returnstring.chomp(",")
	end

  def munsell_color_decorated
    if self.munsell_color.nil? || self.munsell_color == ""
      return I18n.t('undetermined')
    else
      return self.munsell_color
    end
  end

	def max_length_decorated
		if self.max_length.blank? 
			I18n.t('undetermined')
		else
			self.max_length
		end
	end

	def max_width_decorated
		if self.max_width.blank? 
			I18n.t('undetermined')
		else
			self.max_width
		end
	end

	def height_decorated
		if self.height.blank? 
			I18n.t('undetermined')
		else
			self.height
		end
	end

	def opening_dm_decorated
		if self.opening_dm.blank? 
			I18n.t('undetermined')
		else
			self.opening_dm
		end
	end
	
	def bottom_dm_decorated
		if self.bottom_dm.blank? 
			I18n.t('undetermined')
		else
			self.bottom_dm
		end
	end

	def max_dm_decorated
		if self.max_dm.blank? 
			I18n.t('undetermined')
		else
			self.max_dm
		end
	end

	def weight_in_gram_decorated
		if self.weight_in_gram.blank? 
			I18n.t('undetermined')
		else
			self.weight_in_gram
		end
	end

	def coordinates_mega
		"#{self.coordinates_mega_lat} lat; #{self.coordinates_mega_long} long"
	end

	def dating_millennium
		if self.is_dating_millennium_unknown? || self.dating_millennium_begin.blank? || self.dating_millennium_begin.blank?
			return I18n.t('undetermined')
		else
			if self.dating_millennium_begin&.id == self.dating_millennium_end&.id
				return self.dating_millennium_begin&.name
			else
				return self.dating_millennium_begin&.name + " - " + self.dating_millennium_end&.name
			end
		end
	end

	def dating_century
		if self.is_dating_century_unknown? || self.dating_century_begin.blank? || self.dating_century_begin.blank?
			return I18n.t('undetermined')
		else
			if self.dating_century_begin&.id == self.dating_century_end&.id
				return self.dating_century_begin&.name
			else
				return self.dating_century_begin.name + " - " + self.dating_century_end.name
			end
		end
	end

	def dating_period_decorated
		if self.is_dating_period_unknown? || self.dating_period.blank?
			return I18n.t('undetermined')
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
			return I18n.t('undetermined')
		end
		timespan_begin_suffix = ' '
		timespan_end_suffix = ' '
    timespan_begin_suffix += is_dating_timespan_begin_BC? ? I18n.t('bc') : I18n.t('ad')
    timespan_end_suffix += is_dating_timespan_end_BC? ? I18n.t('bc') : I18n.t('ad')
    if dating_timespan_begin.present? && dating_timespan_end.present?
      return dating_timespan_begin&.strftime("%Y") + timespan_begin_suffix + " - " + dating_timespan_end&.strftime("%Y") + timespan_end_suffix
    else
      return ""
    end
  end
	def needs_cleaning_yesno?
		self.needs_cleaning ? I18n.t('yes') : I18n.t('no')
	end

	def needs_conservation_yesno?
		self.needs_conservation ? I18n.t('yes') : I18n.t('no')
	end


  def top_image
    html = ""
    if self&.images&.main&.attachment.nil?
      html = "<div class=\"card-img-dummy\"></div>"
    else
      image = self.images.main.variant(resize_to_limit: [286, 286]) # Default bootstrap 4 card size
			html = self.h.image_tag image, class: "card-img-top"
    end
    
    return helpers.sanitize html
  end
  
  def list_materials
    list = ""
    self&.materials.each do |material|
      list << material.name << "<p>"
    end
    
    return helpers.sanitize list
  end

  def list_material_specifieds
    list = ""
    self&.material_specifieds.each do |ms|
      list << ms.name << "<p>"
    end
    list = I18n.t('undetermined') if list.empty?
    return helpers.sanitize list
  end

  def kind_of_object_decorated
    return self.kind_of_object&.name || I18n.t('undetermined')
  end

  def kind_of_object_specified_decorated
    return self.kind_of_object_specified&.name || I18n.t('undetermined')
  end
  
  def links variant
    links = ""
    if variant.blank? || !variant.class == Hash
      return  helpers.sanitize links
    elsif variant.key?(:edit)
        edit_link = h.link_to I18n.t('edit'), self.h.museum_object_build_path(id, :step_confirm)
        links << edit_link
    elsif
      show_link = h.link_to(I18n.t('show'), self.h.museum_object_path(id))
      links << show_link
    end
    return  helpers.sanitize links
  end
  
end
