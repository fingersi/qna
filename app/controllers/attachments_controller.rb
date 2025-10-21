class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :attachment_find, only: [:destroy]

  def destroy
    notice = if @file.record.author == current_user
               @file.purge
               'attachment was deleted'
             else
               'your are not an author'
             end
    redirect_back(fallback_location: root_path, notice: notice)
  end

  private

  def attachment_find
    @file = ActiveStorage::Attachment.find(params[:id])
  end
end
