class MuseumObjectImageListDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all
  
  def main_image_link
    html = ""
    if self.main.nil?
      html = "not defined"
    else
      html = 
        "<div class=\"col-4\">" + 
          self.link_to(main.blob.filename, main, class: "card-img-top", target:"_blank") + 
        "</div> 
         <div class=\"col-4\">" +
          self.link_to("remove", delete_image_path(main.id, main.id), method: :delete, confirm: "Delete image?", class: "text-warning") +
        "</div>"
    end
    return helpers.sanitize html
  end


end
