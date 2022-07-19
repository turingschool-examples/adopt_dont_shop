class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(pet_application_params)
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    @pet_application = PetApplication.find(params[:id])
    @pet_application.update(pet_application_params)
    redirect_to "/admin/applications/#{@pet_application.application_id}"
  end

private
  def pet_application_params
    params.permit(
      :pet_id,
      :application_id,
      :status
    )
  end

end