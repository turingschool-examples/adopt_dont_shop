class ApplicationPetsController < ApplicationController 
    def create
        ApplicationPet.create(pet_id: permitted_params[:pet_id], application_id: permitted_params[:app_id])
        redirect_to "/applications/#{permitted_params[:app_id]}"
    end 

    def update 
      binding.pry
      # Application.update(permitted_params)
      # redirect_to "/applications/#{permitted_params[:app_id]}"
    end 

    private
    def permitted_params
      permitted_params = params.permit(:app_id, :pet_id, :status)
    end 
end 

