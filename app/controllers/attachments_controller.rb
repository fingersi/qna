class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource class: 'ActiveStorage::Attachment', instance_name: :file

  def destroy
    @file.purge
    redirect_back(fallback_location: root_path, notice: 'attachment was deleted')
  end
  
end
