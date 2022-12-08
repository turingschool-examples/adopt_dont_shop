class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.get_pets
  end
end