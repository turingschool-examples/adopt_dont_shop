class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
  end

end