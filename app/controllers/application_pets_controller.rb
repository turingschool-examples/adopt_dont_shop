class ApplicationPetsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    app_pet = ApplicationPet.create(application_pets_params)
    redirect_to "/applications/#{app_pet.application_id}"
  end

  private

  def application_pets_params
    params.permit(:application_id, :pet_id)
  end
end
