class MuseumCardDecorator < Draper::Decorator
  decorates :museum_object
  delegate_all

  def top_image
    html = ""
    if self&.main_image&.attachment.nil?
      html = "<div class=\"card-img-dummy\"></div>"
    else
      html = self.h.image_tag self&.main_image, class: "card-img-top"
    end
    
    return helpers.sanitize html
  end
  
  def list_materials
    list = ""
    self&.termlist_materials.each do |material|
      list << material.name << "<p>"
    end
    
    return helpers.sanitize list
  end
  
  
end
