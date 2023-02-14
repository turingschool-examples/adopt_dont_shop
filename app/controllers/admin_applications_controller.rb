class AdminApplicationsController < ApplicationController 
  def show 
    
    @application = Application.find(params[:id])
    # @pets = @application.pets
    @pet_applications = @application.pet_applications
  end

  def update 
    
    pet_application = PetApplication.find(params[:id]) #get specific pet_app with pet_1 and app_1
    pet_application.update!(status: params[:status]) #update specific app_1, pet_1 id
    # require 'pry'; binding.pry
    application = pet_application.application #specific applicant app_1
    pet_applications = application.pet_applications #all of app_1's pet_applications
  # require 'pry'; binding.pry
    
    if application.application_status_count("Rejected") > 0 
      application.update!(status: "Rejected")
    elsif application.application_status_count("Accepted") == pet_applications.count
      application.update!(status: "Accepted")
    end
  
    redirect_to "/admin/applications/#{application.id}"
  end
end