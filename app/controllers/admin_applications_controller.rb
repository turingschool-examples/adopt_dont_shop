class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    # require 'pry'; binding.pry
  end

  def update
    pet_application = PetApplication.where(application_id: params[:id], pet_id: params[:pet_id])
    if params[:approved] == "true"
      pet_application.update(approved: "true")
    else params[:approved] == "false"
      pet_application.update(approved: "false")
    end
     redirect_to "/admin/applications/#{params[:id]}"
  end

  private
  def pet_applications_params
    params.permit(:approved)
  end

end
