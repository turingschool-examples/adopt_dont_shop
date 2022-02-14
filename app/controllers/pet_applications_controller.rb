class PetApplicationsController < ApplicationController

  def create
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create!(pet_id: pet.id, application_id: application.id)
    redirect_to "/applications/#{params[:id]}"
  end
end
