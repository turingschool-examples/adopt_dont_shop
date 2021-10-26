class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])

    if params[:pet_id]
      petapp = application.find_pet_application(params[:pet_id])
    end

    if petapp && params[:commit] == 'Approve'
      petapp.update(approved: true)
    elsif petapp && params[:commit] == 'Reject'
      petapp.update(approved: false)
    end

    redirect_to "/admin/applications/#{application.id}"
  end
end
