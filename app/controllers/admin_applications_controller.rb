class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if @application.all_pets_approved?
      @application.update(status: "Approved")
    elsif @application.any_pets_rejected?
      @application.update(status: "Rejected")
    end
  end
end
