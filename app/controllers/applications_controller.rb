class ApplicationsController < ApplicationController

  def new
    
  end

  def create
    new_app = Application.create(application_params)

    redirect_to "/applications/#{new_app.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end