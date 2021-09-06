class ApplicationPetsController < ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    @application_pet = ApplicationPet.create(pet: pet, application: application)
    redirect_to "/applications/#{application.id}"
  end
end
