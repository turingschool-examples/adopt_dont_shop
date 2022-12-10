class PetApplicationsController < ApplicationController
  def create
    pet = Pet.find(create_params[:pet_id])
    application = Application.find(create_params[:application_id])
    PetApplication.create!(pet: pet, application: application)
    
    redirect_to "/applications/#{create_params[:application_id]}"
  end


  private

  def create_params
    params.permit(:pet_id, :application_id)
  end
end