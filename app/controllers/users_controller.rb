class UsersController < ApplicationController
  
  def show
    if params[:username]
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
    @public_locations = @user.locations.public_locations
    @private_locations = @user.locations.private_locations
    @shared_locations = @user.shared_locations
  end

end