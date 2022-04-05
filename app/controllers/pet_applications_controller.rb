class PetApplicationsController < ApplicationController
  def create
    PetApplication.create(application_id: params[:application_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:application_id]}"
  end

  private

  def pet_application_params
    params.permit(:application_id, :pet_id)
  end
end
