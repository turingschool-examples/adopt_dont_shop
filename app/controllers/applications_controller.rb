class ApplicationsController < ApplicationController

  def show
      @application = Application.find(params[:id])
      @pets = @application.pets
  end
  
  def new
  end

  def create
    new_app = Application.create(application_params)
    new_app.update(status: "In Progress")
    redirect_to "/applications/#{new_app.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end

end