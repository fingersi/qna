class AttachmentController < ApplicationController
  def delete
    file = ActiveStorage::Attachment.find(params[:id])
    file.purge 
    redirect_back(fallback_location: root_path)
  end
end
