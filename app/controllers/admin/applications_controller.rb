class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
  end

  def update
    pet_app = PetApplication.find_pet_app(params[:pet_id], params[:application_id])
    pet_app.update({app_status: params[:status]})
    application = Application.find(params[:application_id])
    pets = application.pets
    pet_app_count = PetApplication.pet_app_count(params[:application_id])
    pet_app_approved_count = PetApplication.pet_app_approved_count(params[:application_id])
    pet_app_approved_count == pet_app_count ? application.update({status: "Approved"}) && update_pet_status(pets) : nil 
    pet_app_rejected_count = PetApplication.pet_app_rejected_count(params[:application_id])
    pet_app_rejected_count > 0 ? application.update({status: "Rejected"}) : nil
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  def update_pet_status(pets)
    pets.update({adoptable: false})
  end
end