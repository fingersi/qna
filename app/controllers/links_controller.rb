class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :link_find, only: [:destroy]

  def destroy
    notice = if @link.linkable.author == current_user
               @link.destroy
               'Link was deleted'
             else
               'your are not an author'
             end
    redirect_back(fallback_location: root_path, notice: notice)
  end

  private

  def link_find
    @link = Link.find(params[:id])
  end
end
