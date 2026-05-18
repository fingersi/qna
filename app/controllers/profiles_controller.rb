class ProfilesController < ApplicationController
  before_action :authenticate_user!

  check_authorization

  def show
    @user = current_user
    authorize! :profile, @user

  end
end
