class ApplicationPetsController < ApplicationController

  def create
    application_pet = ApplicationPet.new(app_pet_params)
    application_pet.save
    redirect_to "/applications/#{params[:application_id]}"
  end
  
  def update
    application_pet = ApplicationPet.find_app(params[:application_id], params[:pet_id])
    application_pet.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
  #method where app_id = params app_id
  #method where pet_id = params pet_id -model
  private
  def app_pet_params
    params.permit(params[:application_id], params[:pet_id])
  end
end