class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    application.update(status: params[:status])
    redirect_to "/admin/applications/#{application.id}"
  end
end
