class MuseumObjectImageListDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all
  
  def remove_from_list image_id
    self.list.find(image_id).purge
    #redirect_back(fallback_location: root_path)
  end

end
