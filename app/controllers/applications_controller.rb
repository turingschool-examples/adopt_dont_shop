class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    new_application = Application.create!(new_application_params)
    redirect_to "/applications/#{new_application.id}"
  end

  private

  def new_application_params
    {
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      status: "In Progress"
    }
  end

end
