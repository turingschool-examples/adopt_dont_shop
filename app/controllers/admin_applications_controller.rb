class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    if application.status == 'Pending'
      application.update!(status: 'Approved')
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end
