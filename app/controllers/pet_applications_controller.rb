class PetApplicationsController < ApplicationController
    def create
        pet = Pet.find(params[:pet_id])
        application = Application.find(params[:application_id])
        pet_application_association = PetApplication.create!(pet: pet, application: application)
        redirect_to "/applications/#{application.id}"
    end
end



