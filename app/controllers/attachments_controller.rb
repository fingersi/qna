class AttachmentsController < ApplicationController

  before_action :attachment_find, only: [:destroy]
 
  def destroy
    if @file.record.author == current_user
      @file.purge
      notice = 'attachment was deleted'
    else
      notice = 'your are not an anuthor'
    end
 
    redirect_back(fallback_location: root_path, notice: 'file deleted')
  end

  private

  def attachment_find
    @file = ActiveStorage::Attachment.find(params[:id])
  end
end
