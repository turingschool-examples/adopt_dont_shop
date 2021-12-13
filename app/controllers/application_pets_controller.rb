class ApplicationPetsController < ApplicationController

  def create
    @pet_application = ApplicationPet.create(application_pet_params)
    
    redirect_to "/applications/#{@pet_application.application_id}"
  end

private
  def application_pet_params
    params.permit(:application_id, :pet_id)
  end
end
