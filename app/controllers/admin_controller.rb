class AdminController < ApplicationController

  def index
    @shelters = Shelter.reverse_alphabetical
    @app_shelters = Shelter.pending_apps
  end

  def show
   @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @application.update(status: "Approved")
    redirect_to "/admin/applications/#{@application.id}"
  end
end