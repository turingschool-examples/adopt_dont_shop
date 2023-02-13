class AdminApplicationsController < ApplicationController 
  def show 
    
    @application = Application.find(params[:id])
    # @pets = @application.pets
    @pet_applications = @application.pet_applications
  end

  def update 
    pet_application = PetApplication.find(params[:id])
    status_updated = pet_application.application.update(status: params[:status])

      
    # require 'pry'; binding.pry
    redirect_to "/admin/applications/#{pet_application.application.id}"
  end
end