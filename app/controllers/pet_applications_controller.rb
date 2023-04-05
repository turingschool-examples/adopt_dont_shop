class PetApplicationsController < ApplicationController
  
  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create(pet: pet, application: application)
    redirect_to "/applications/#{application.id}"
  end

  def update
    pet_app = PetApplication.find(params[:id])
    application = Application.find(pet_app.application.id)
    if params[:approved] == "true"
      pet_app.update(approved: true)
    else
      pet_app.update(approved: false)
    end
    update_application(application)
    redirect_to "/admin/applications/#{pet_app.application.id}"
  end

  def update_application(application)
    if application.has_pending_pets?
    elsif application.has_rejected_pets?
      application.update(status: 3)
    else
      application.update(status: 2)
      application.update_pets
    end
  end
end