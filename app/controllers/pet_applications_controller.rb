class PetApplicationsController < ApplicationController

  def create
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create!(pet_id: pet.id, application_id: application.id)
    redirect_to "/applications/#{params[:id]}"
  end

  def approve
    pet_app = PetApplication.find(params[:id])
    pet_app.update(status: "Approved")
    redirect_to "/admin/applications/approve/#{pet_app.application_id}"
  end

  def reject
    pet_app = PetApplication.find(params[:id])
    pet_app.update(status: "Rejected")
    redirect_to "/admin/applications/reject/#{pet_app.application_id}"
  end
end
