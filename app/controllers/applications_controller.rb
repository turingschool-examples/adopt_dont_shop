class ApplicationsController < ApplicationController
  
  
  
  def new
    
  end

  def create
    app = Application.create(application_params)
    redirect_to "applications/#{app.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status)
  end
end