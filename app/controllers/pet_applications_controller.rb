class PetApplicationsController < ApplicationController

  def create
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create(pet_id: pet.id, application_id: application.id)
    # application.add_pet?(pet)
    redirect_to "/applications/#{application.id}"
  end 

end
