class LocationsController < ApplicationController

  def create
    @location = current_user.locations.build(clean_params)
    @location.public_site = @location.shared_user_ids.empty?
    if @location.save
      redirect_to @location
    else
      render "new"
    end
  end

  def new
    @location = current_user.locations.build
  end

  def show
    @location = Location.find(params[:id])
  end

  private

  def permitted_params
    params.require(:location).permit(:latitude, :longitude, { shared_user_ids: [] }, :shared_user_ids)
  end

  def clean_params
    params = permitted_params
    shared_user_params = params['shared_user_ids']
    params['shared_user_ids'] = shared_user_params.count > 1 ?  shared_user_params.reject(&:empty?) : []
    params
  end

end