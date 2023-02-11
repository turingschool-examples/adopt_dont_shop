class ApplicationPetsController < ApplicationController

  def create
    @app_pet = ApplicationPet.create!(app_pet_params)
    redirect_to "/applications/#{@app_pet.application_id}"
  end

  private
  def app_pet_params
    params.permit(:application_id, :pet_id)
  end
end