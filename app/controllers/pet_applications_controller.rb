class PetApplicationsController < ApplicationController
  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create(pet: pet, application: application)

    redirect_to "/applications/#{application.id}"
  end
end
