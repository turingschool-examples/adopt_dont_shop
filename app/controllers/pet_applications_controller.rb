class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(pet_application_attributes)
    redirect_to "/applications/#{params[:application_id]}"
  end

  def pet_application_attributes 
    params.permit(:application_id, :pet_id)
  end

end