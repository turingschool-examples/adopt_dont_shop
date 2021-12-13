class ApplicationPetsController < ApplicationController

  def create
    @application_pets = ApplicationPet.create(application_pet_params)
    redirect_to "/applications/#{@application_pets.application_id}"
  end

  private

  def application_pet_params
    params.permit(:application_id, :pet_id)
  end

end
