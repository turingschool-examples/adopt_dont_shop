class AdminApplicationsController < ApplicationController
  def show
    @application_pets
    @application = Application.find(params[:application_id])
    @pets = @application.pets
  end
end