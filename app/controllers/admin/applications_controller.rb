class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets 
    @pet_apps = PetApplication.where(application_id: params[:application_id])
  end

  def update
    pet_app = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_id])
    pet_app.update({status: params[:status]})
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end