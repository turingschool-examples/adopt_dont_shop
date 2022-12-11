class ApplicationPetsController < ApplicationController
  def create
    application_pet = ApplicationPet.new({application_id: params[:application_id], pet_id: params[:pet_id]})
    application_pet.save
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    application_pet = ApplicationPet.find_application_pet(params[:application_id], params[:pet_id])

    application_pet.update(pet_status: params[:status])

    application_pet.save

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end