class ApplicationsPetsController < ApplicationController

  def create
    @application_pet = ApplicationsPet.create(new_applications_pets_params)

    redirect_to "/applications/#{@application_pet.application_id}"
  end

  private

  def new_applications_pets_params
    params.permit(:application_id, :pet_id)  
  end
end