class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
  end

  def update
    pet_app = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_id])
    pet_app.update({app_status: params[:status]})
    application = Application.find(params[:application_id])
    pets = application.pets
    pet_app_count = PetApplication.where(application_id: params[:application_id]).count
    pet_app_approved_count = PetApplication.where("application_id = ? AND app_status = ?", params[:application_id], "Approved").count
    pet_app_approved_count == pet_app_count ? application.update({status: "Approved"}) && update_pet_status(pets) : nil 
    pet_app_rejected_count = PetApplication.where("application_id = ? AND app_status = ?", params[:application_id], "Rejected").count
    pet_app_rejected_count > 0 ? application.update({status: "Rejected"}) : nil
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  def update_pet_status(pets)
    pets.each do |pet|
      pet.update({adoptable: false})
    end
  end
end