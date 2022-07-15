class ApplicationsController < ApplicationController

    def show
        @application = Application.find(params[:application_id])
        if params[:search] != nil 
            @pets = Pet.find_by_name(params[:search])
        else     
            @pets = []
        end 
    end

    def apppetscrreate
        application = Application.find(params[:application_id])
        pet = Pet.find(params[:pet_id])
        PetApplication.create(pet: pet, application: application)
        redirect_to "/applications/#{application.id}"
    end 
end  