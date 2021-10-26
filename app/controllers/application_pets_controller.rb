class ApplicationPetsController < ApplicationController 
    def create
        Application.find(new_association[:app_id]).pets << Pet.find(new_association[:pet_id])
        redirect_to "/applications/#{new_association[:app_id]}"
    end 

    private
    def new_association
        new_association = params.permit(:app_id, :pet_id)
    end 
end 

