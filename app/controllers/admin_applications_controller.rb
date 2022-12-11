class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
  end
end