class MuseumObjectImageListsController < ApplicationController
  def delete_image
    if params[:id].nil? || params[:image_id].nil?
      flash[:error] = "could not find image for deletion"
      redirect_back(fallback_location: root_path)
    end
    
    images = MuseumObjectImageList.find_by(id: params[:id])
    image = images&.list&.find_by(id: params[:image_id])
    result = image&.purge_later
    if result.nil?
      flash[:error] = "could not find image for deletion"
    else
      flash[:success] = "image deleted"
    end
    redirect_back(fallback_location: root_path)
  end

end
