class LinksController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def destroy
    @link.destroy
    redirect_back(fallback_location: root_path, notice: 'Link was deleted')
  end

end
