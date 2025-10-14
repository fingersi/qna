class LinksController < ApplicationController

  before_action :link_find, only: [:destroy]
 
  def destroy
    if @link.linkable.author == current_user
      @link.destroy
      notice = 'Link was deleted'
    else
      notice = 'your are not an author'
    end
 
    redirect_back(fallback_location: root_path, notice: 'link deleted')
  end

  private

  def link_find
    @link = Link.find(params[:id])
  end
end
