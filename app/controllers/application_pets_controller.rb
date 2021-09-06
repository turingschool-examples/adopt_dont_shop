class ApplicationPetsController < ApplicationController
  def create
    @app_pets = ApplicationPet.create!(app_pets_params)
    redirect_to "/applications/#{@app_pets.application_id}"
  end

  private

  def app_pets_params
    params.permit(:application_id, :pet_id)
  end
end
