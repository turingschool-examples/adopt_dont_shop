class ApplicationsController < ApplicationController

    def new 
    end

    def create
        application = Application.create!(application_params)
        redirect_to "/applications/#{application.id}"
    end

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
    
    private
    def application_params
        params.permit(:name, :street, :city, :state, :zipcode, :description)
    end 


end  