class ApplicationPetsController < ApplicationController
  
  def create
    @application = Application.find(params[:id])
    @pet = @application.pets.first
    @pet_app = ApplicationPet.create!(application: @application, pet: @pet)
    redirect_to "/applications/#{@application.id}"
  end

  def application_pet_params
    params.permit(:application_id, :pet_id)
  end


end