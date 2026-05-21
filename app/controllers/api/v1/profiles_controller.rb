class Api::V1::ProfilesController < Api::V1::BaseController 

  def me
    authorize! :read, :profile
    render json: current_resource_owner
  end

  def other_users
    authorize! :read, :other_users
    render json: User.where.not(id: current_resource_owner.id)
  end

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end
