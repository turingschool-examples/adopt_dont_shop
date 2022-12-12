class ApplicationPetsController < ApplicationController
  def create
    application_pet = ApplicationPet.create!(application_id: params[:application_id], pet_id: params[:pet_id])
    application_pet.update(approval: nil)
    redirect_to "/applications/#{params[:application_id]}?addpet=success"
  end

  def update
    application_pet = ApplicationPet.find(params[:id])
    
    application_pet.update(application_pets_params)

    redirect_to "/admin/applications/#{application_pet.application.id}"
  end

private
  def application_pets_params
    params.permit(:id, :application_id, :pet_id, :approval)
  end
end