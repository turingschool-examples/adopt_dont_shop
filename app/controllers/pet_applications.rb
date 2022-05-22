class PetApplicationsController < ApplicationController

  def create
    PetApplication.create(petapplication_params)
    redirect_to "/applications/#{:application_id}"
  end
  

  private

  def petapplication_params
    params.permit(:pet_id, :application_id)
  end

end