class ApplicationPetsController < ApplicationController
  def create
    application = Application.find(params[:id])
    pet         = Pet.find(params[:pet_id])
    if application.pets.include?(pet)
      flash[:alert] = "Error: Pet already added."
    else
      application.pets << pet
    end
    redirect_to "/applications/#{params[:id]}"
  end
end
