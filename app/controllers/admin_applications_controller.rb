class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end
end