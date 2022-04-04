class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets

  end

  def update
    application = Application.find(params[:id])
    application_pet = ApplicationPet.find(application.application_pets.ids.first)
    application_pet.update(approved: params[:approved])
    redirect_to "/admin/applications/#{application.id}"
  end
end
