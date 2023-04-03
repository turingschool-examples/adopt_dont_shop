class ApplicationPetsController < ApplicationController

  def new
    ApplicationPet.create!(application_id: params[:application_id], pet_id: params[:id])
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    if 
      application_pet = ApplicationPet.where(application_id: params[:id], pet_id: params[:pet_id])
      app.application_pets.update(status: 'Approved')
    else
      
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def app
    Application.find(params[:id])
  end
end