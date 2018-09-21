class MuseumCardDecorator < Draper::Decorator
  decorates :museum_object
  delegate_all

  def top_image
    html = ""
    if self&.images&.main&.attachment.nil?
      html = "<div class=\"card-img-dummy\"></div>"
    else
      html = self.h.image_tag self.images.main, class: "card-img-top"
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
    
    return helpers.sanitize list
  end
  
  def links variant
    links = ""
    if variant.blank? || !variant.class == Hash
      return  helpers.sanitize links
    else
      if variant.key?(:edit)
        edit_link = h.link_to "edit", self.h.museum_object_build_path(id, :step_confirm)
        links << edit_link
      end
    end
    return  helpers.sanitize links
  end
  
  
end
