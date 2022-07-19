class PetApplicationsController < ApplicationController
  def admin_approve
    pet_app = PetApplication.find(params[:id])
    @application = pet_app.application

    pet_app.status = "Accepted"
    if pet_app.save
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end
