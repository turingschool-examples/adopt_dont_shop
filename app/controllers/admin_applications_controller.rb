class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
  end

  def update
    pet_application = PetApplication.find(params[:pet_app_id])
    pet_application.update(pet_status: 'Accepted')
    redirect_to "/admin/applications/#{params[:id]}"
  end
end