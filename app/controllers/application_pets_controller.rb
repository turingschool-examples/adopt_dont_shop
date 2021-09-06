class ApplicationPetsController < ApplicationController
  def create
    application_pets = ApplicationPet.create(application_id: params[:application_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:application_id]}"
  end
end
