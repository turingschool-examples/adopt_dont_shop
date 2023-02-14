class AdminApplicationsController < ApplicationController 
  def show 
    
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
  end

  def update 
    @pet_application = PetApplication.find(params[:id]) 
    @pet_application.update!(status: params[:status]) 

    @application = @pet_application.application 
    @pet_applications = @application.pet_applications 

    # Later user story, dosn't do anything right now
    if @application.application_status_count("Rejected") > 0 #.any?
      @application.update!(status: "Rejected")
    elsif @application.application_status_count("Accepted") == @pet_applications.count 
      @application.update!(status: "Accepted")
    end
    
    redirect_to "/admin/applications/#{@pet_application.application_id}"
  end
end