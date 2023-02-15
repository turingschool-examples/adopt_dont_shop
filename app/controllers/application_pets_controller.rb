class ApplicationPetsController < ApplicationController

  def create
    ApplicationPet.create!(applicaton_pet_params)
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    @application = Application.find(params[:id])
    @application_pet = ApplicationPet.find(params[:app_pet_id])
    @application_pet.update!(status: params[:status])
    @application_pet.save
    redirect_to "/admin/applications/#{@application.id}"
  end

private
  def applicaton_pet_params
    params.permit(:application_id, :pet_id, :status)
  end
end