class ApplicationPetsController < ApplicationController

  def create
    application_id = request.path.split('/')[2]
    pet_id = params[:id]
    ApplicationPet.create!(application_id: application_id, pet_id: pet_id)
    redirect_to "/applications/#{application_id}"
  end
end
