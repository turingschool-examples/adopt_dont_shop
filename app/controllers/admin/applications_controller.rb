class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
  end

  def update
    pet_app = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_id])
    pet_app.update({app_status: params[:status]})
    application = Application.find(params[:application_id])
    pet_app_count = PetApplication.where(application_id: params[:application_id]).count
    pet_app_approved_count = PetApplication.where("application_id = ? AND app_status = ?", params[:application_id], "Approved").count
    pet_app_approved_count == pet_app_count ? application.update({status: "Approved"}) : nil 
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end