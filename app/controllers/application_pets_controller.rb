class ApplicationPetsController < ApplicationController

  def create
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_app = ApplicationPet.create!(application: @application, pet: @pet)
    redirect_to "/applications/#{@application.id}"
  end


  def update
    @pet_app = ApplicationPet.find(params[:id])
    @pet_app.application.approve!

    redirect_to "/admin/applications/#{@pet_app.application_id}"
  end

  def application_pet_params
    params.permit(:application_id, :pet_id)
  end
end
