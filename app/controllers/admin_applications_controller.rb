class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
  end

  def update
    @application = Application.find(params[:application_id])
    application_pet = ApplicationPet.find_application_pet(params[:application_id], params[:pet_id])
    application_pet.update!(admin_application_params)

    @application.update_status!

    redirect_to "/admin/applications/#{params[:application_id]}"
  end

private
  def admin_application_params
    params.permit(:status)
  end
end
