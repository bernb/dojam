class MuseumObjectImageListsController < ApplicationController
  def delete_image
    if params[:id].nil? || params[:image_id].nil?
      flash[:danger] = t('could_not_find_image_for_deletion')
      redirect_back(fallback_location: root_path)
    end
    
    # Note that if no main image attached, 
    # images.main&.id will NOT return nil but a DelegationError
    
    result = ActiveStorage::Attachment.where(record_id: params[:id], id: params[:image_id])&.first&.purge
    
    if result.nil?
      flash[:danger] = t('could_not_find_image_for_deletion')
    else
      flash[:success] = t('image_deleted')
    end
    redirect_back(fallback_location: root_path)
  end

end
