class PetApplicationsController < ApplicationController
  def create
    PetApplication.create(pet_app_params)
    application = Application.find(params[:application_id])
  end

  private

  def pet_app_params
    params.permit(:application_id, :pet_id)
  end
end
