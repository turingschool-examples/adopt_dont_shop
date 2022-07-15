class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def create
    @application = Application.find(params[:id])
      @application.pets.create(app_params)
      redirect_to "/applications"
    end

private

  def app_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip_code)
  end
end
