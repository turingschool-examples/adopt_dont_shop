class AdminsController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelter
    @pending_shelters = Shelter.pending_apps
  end

  def show
    @application = Application.find(params[:id])
    if params[:app_status] == "Approved"
      @application.update(status: "Approved")
    end
    @pets = @application.pets
  end
end
