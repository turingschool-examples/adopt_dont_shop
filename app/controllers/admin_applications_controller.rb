class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @petapps     = PetApplication.all.where(application_id: params[:id])
  end

  def update
    application = Application.find(params[:id])

    if params[:pet_id]
      petapp = PetApplication.all.where(pet_id: params[:pet_id]).where(application_id: params[:id])
    end

    if petapp && params[:commit] == 'Approve'
      petapp.update(approved: true)
    elsif petapp && params[:commit] == 'Reject'
      petapp.update(approved: false)
    end

    redirect_to "/admin/applications/#{application.id}"
  end
end
