class PetAppsController < ApplicationController

  def create
    if PetApp.create(pet_app_params)
      redirect_to "/apps/#{pet_app_params[:app_id]}"
    end
  end
  private
  def pet_app_params
    params.permit(:app_id, :pet_id)
  end

end