class AppPetsController < ApplicationController
  def create
    @app_pets = AppPet.create!(app_pets_params)
    redirect_to "/apps/#{@app_pets.app_id}"
  end

  private 
  
  def app_pets_params
    params.permit(:app_id, :pet_id)
  end
end 