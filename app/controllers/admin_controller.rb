class AdminController < ApplicationController
    def index 
        @shelters = Shelter.reverse_alphabetical_shelters
        @shelters_pending_apps = Shelter.shelters_with_pending_apps
    end 

    def show
        @application = Application.find(params[:id])
        # Probably should move this to model level 
        @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zipcode}"
        @undetermined_pets = PetApplication.find_nil_pets(@application)
        @approved_pets = PetApplication.find_approved_pets(@application)
    end 

    def update 
        application = Application.find(params[:id])
        if params[:approve]
            pet = Pet.find(params[:approve])
            accepted_joins_row = (PetApplication.find_joins_row(application, pet)).first
            accepted_joins_row.Accepted!
            redirect_to "/admin/applications/#{application.id}"
        end 
    end 
end