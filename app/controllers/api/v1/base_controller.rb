class Api::V1::BaseController < ApplicationController  
  
  before_action -> { doorkeeper_authorize! :public, :write, :update }
 
  protect_from_forgery with: :null_session, prepend: true
  
  private

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  alias_method :current_user, :current_resource_owner
end