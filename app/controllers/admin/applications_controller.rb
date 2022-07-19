class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications

    if !@application.pending_pet_applications? && @application.any_rejected_pet_applications?
      @application.reject_application
    elsif !@application.pending_pet_applications? && @application.all_accepted_pet_applications?
      @application.approve_application
    else
      @application
    end
  end
end