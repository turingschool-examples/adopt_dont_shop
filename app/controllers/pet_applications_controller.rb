class PetApplicationsController < ApplicationsController 
   def create 
      # binding.pry
      # @pet = Pet.create!(params[:pet_id])
      # @application = Application.create!(params[:application_id])
      @pet_application = PetApplication.create(pet_application_params)
      redirect_to "/applications/#{@pet_application.application_id}"
      # @pet_application.save
   end 

   private 
   def pet_application_params
      params.permit(:pet_id, :application_id)
   end
end