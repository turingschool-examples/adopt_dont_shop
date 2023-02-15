class ApplicationPetsController < ApplicationController

  def create
    ApplicationPet.create!(applicaton_pet_params)
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    ApplicationPet.update(applicaton_pet_params)
    redirect_to "admin/applications/#{params[:application_id]}"
  end

private
  def applicaton_pet_params
    params.permit(:application_id, :pet_id, :status)
  end
end