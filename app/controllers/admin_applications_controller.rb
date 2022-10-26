class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets 
    @app_pets = @application.application_pets
  end

  def update
    application = Application.find(params[:id])
    app_pet = ApplicationPet.app_pet(application, params[:pet])
    app_pet.update(status: params[:status])

    redirect_to "/admin/applications/#{application.id}"
  end

end