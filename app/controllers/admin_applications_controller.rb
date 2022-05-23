class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    app = PetApplication.where(application_id: params[:id]).where(pet_id: params[:pet_id])
    app.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
