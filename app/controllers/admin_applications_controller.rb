class AdminApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications #shows all pet_applications/we only want one
    @pets = @application.pets #shows all pets on application 
    #  require 'pry'; binding.pry
  end

  def update
    pet_application = PetApplication.find(params[:id])
    pet_application.update(pet_applications_params)
    redirect_to "/admin/applications/#{pet_application.application.id}"
  end

  private 
    def pet_applications_params
      params.permit(:approved)
    end

end