class PetApplicationsController < ApplicationController
  def create
    pet = params[:pet]
    PetApplication.create(pet_id: pet.id, application_id: pet.shelter.id)
  end

  private

  def pet_app_params
    params.permit(:pet_id, :application_id)
  end
end
