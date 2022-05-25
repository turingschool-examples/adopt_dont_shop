class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
  end

  def update
    pet_application = PetApplication.find(params[:id])
    pet_application.update(status: params[:pet_status])
    pet_application.application.status_update
    redirect_to "/admin/applications/#{pet_application.application.id}"
  end
end