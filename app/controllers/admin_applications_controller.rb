class AdminApplicationsController < ApplicationController
  def show
    @applications = Application.find(params[:id])
  end

  def edit

  end

  def update
    # require "pry"; binding.pry
    application = Application.find(params[:id])
    application.update(status: "Approved!")
    redirect_to "/admin/applications/#{application.id}"
  end
end
