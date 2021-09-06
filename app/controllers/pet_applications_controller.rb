class PetApplicationsController < ApplicationController

  def create
    app = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])

    app.pets << pet
    redirect_to "/applications/#{params[:application_id]}"
  end
end
