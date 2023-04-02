class PetApplicationsController < ApplicationController
  
  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create(pet: pet, application: application)
    redirect_to "/applications/#{application.id}"
  end

  def update
    pet_app = PetApplication.find(params[:id])
    if params[:approved] == "true"
      pet_app.update(approved: true)
    else
      pet_app.update(approved: false)
    end
    redirect_to "/admin/applications/#{pet_app.application.id}"
  end
end