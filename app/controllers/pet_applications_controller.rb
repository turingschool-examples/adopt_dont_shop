class PetApplicationsController < ApplicationController
  def show
    @app = PetApplication.find(params[:id])

    @pets = PetApplicationPet.where(pet_application_id: params[:id])
  end
end
