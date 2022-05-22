class AdminApplicationsController < ApplicationController 
    def index
        @applications = Application.all
    end
    
    def show
        @application = Application.find(params[:id])
    end

    def update
        application_pet = ApplicationPet.find(params[:app_id])
        if params[:status] == 'Approve'
            application_pet.pet_status = 'Approved'
        elsif params[:status] == 'Reject'
            application_pet.pet_status = 'Rejected'
            application_pet.application.status = 'Rejected'
        end
        application_pet.save
        application_pet.application.save
        redirect_to "/admin/applications/#{application_pet.application.id}"
    end
    
    
end