class PetApplicationsController < ApplicationController

  def create
    @pet_application = PetApplication.create(application_id: params[:application_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:application_id]}"
    
  end
  

  private

  def pet_application_params
    params.permit(:pet_id, :application_id)
  end

end