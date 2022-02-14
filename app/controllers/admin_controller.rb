class AdminController < ApplicationController
    def index 
        @shelters = Shelter.reverse_alphabetical_shelters
        @shelters_pending_apps = Shelter.shelters_with_pending_apps
    end 

    def show
        @application = Application.find(params[:id])
        @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zipcode}"
        @undetermined_pets = PetApplication.find_nil_pets(@application)
        @approved_pets = PetApplication.find_approved_pets(@application)
        @rejected_pets = PetApplication.find_rejected_pets(@application)
        if @approved_pets == @application.pets
            @application.Accepted!
            binding.pry
            # @application.update(application_params)
        end 
    end 

    def update 
        application = Application.find(params[:id])
        approved_pets = PetApplication.find_approved_pets(application)
        if params[:approve]
            pet = Pet.find(params[:approve])
            accepted_joins_row = (PetApplication.find_joins_row(application, pet)).first
            accepted_joins_row.Accepted!
            # approved_pets = PetApplication.find_approved_pets(application)
            # if application.pets == approved_pets
            #  application.Accepted!
            # end 
            redirect_to "/admin/applications/#{application.id}"
        end 

        if params[:reject]
            pet = Pet.find(params[:reject])
            rejected_joins_row = (PetApplication.find_joins_row(application, pet)).first
            rejected_joins_row.Rejected!
            redirect_to "/admin/applications/#{application.id}"
        end 
    end 

private 
    def application_params
        params.permit(:description, :status)
    end 
end