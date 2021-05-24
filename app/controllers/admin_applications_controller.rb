class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets_adopting = @application.pets
  end
end