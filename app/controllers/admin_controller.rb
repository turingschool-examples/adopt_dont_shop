class AdminController < ApplicationController

  def index
    @shelters = Shelter.reverse_alphabetical
    @app_shelters = Shelter.pending_apps
  end

  def show
   @application = Application.find(params[:id])
  # flash[:notice] = "Approved!" if @application.status == "Approved"
    # redirect_to "/admin/applications/#{@application.id}"
  end

  def create
    require 'pry'; binding.pry
  end
end