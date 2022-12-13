class AdminApplicationsController < ApplicationController 

  def show 
    @application = Application.find(params[:id])
  end
  
  def update
    app_pet = ApplicationPet.find(params[:pet_id])
    app_pet.update(admin_applications_params)
    app_pet.save
    redirect_to "/admin/applications/#{app_pet.application.id}"
  end

  private
  def admin_applications_params
    params.permit(:status)
  end
end