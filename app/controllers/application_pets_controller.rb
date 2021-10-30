class ApplicationPetsController < ApplicationController
  def create
    @application_pet = ApplicationPet.create(pet_id: params[:pet_id], application_id: params[:id])
    redirect_to "/applications/#{@application_pet.application_id}"
  end
end
