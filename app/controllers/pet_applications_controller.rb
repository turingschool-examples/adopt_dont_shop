class PetApplicationsController < ApplicationController
  def create
    pet_application = PetApplication.new(pet_application_params)
    if pet_application.save
      redirect_to "/applications/#{params[:application_id]}"
    else
      flash[:notice] = "Application not created: Required information missing."
      redirect_to  "/applications/#{params[:application_id]}"
    end
  end

  private
  def pet_application_params
    params.permit(:pet_id, :application_id)
  end
end