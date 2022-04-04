class ApplicationPetsController < ApplicationController

  def create
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    application_pet = ApplicationPet.create!(pet_id: pet.id, application_id: params[:id])
    redirect_to "/applications/#{application.id}"
  end

end
