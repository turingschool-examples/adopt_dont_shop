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
    @application.params_status(@application, params[:status])
    redirect_to "/admin/applications/#{@application.id}"
  end
end