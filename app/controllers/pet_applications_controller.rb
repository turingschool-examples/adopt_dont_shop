class PetApplicationsController < ApplicationController
  def create
    PetApplication.create(pet_id: :pet_id, application_id: :application_id)
  end

  private

  def pet_app_params
    params.permit(:pet_id, :application_id)
  end
end
