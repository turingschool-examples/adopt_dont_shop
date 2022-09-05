class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters
    @pending = Shelter.pending_apps
  end

  def show
    @application = Application.find(params[:id])
  end

  def approve_deny
    @application = Application.find(params[:id])
    if params[:approved]
      @application.update_attribute(:status, "Approved")
    elsif params[:rejected]
      @application.update_attribute(:status, "Rejected")
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end