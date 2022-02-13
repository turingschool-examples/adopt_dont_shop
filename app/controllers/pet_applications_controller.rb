class PetApplicationsController < ApplicationController
  def create
    @app_and_pet = PetApplication.create(pet_app_params)
    redirect_to "/applications/#{@app_and_pet.application_id}"
  end

  private
  def pet_app_params
    params.permit(:application_id, :pet_id)
  end
end
