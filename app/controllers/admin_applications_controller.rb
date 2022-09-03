class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.app_pets_and_pets
  end

  def update
    @application_pet = ApplicationPet.find(params[:ap_id])
    @application_pet.update(status: params[:status])
    redirect_to("/admin/applications/#{params[:id]}")
  end

end