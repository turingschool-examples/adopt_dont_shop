class ApplicationsController < ApplicationController

  def index
  end
  
  def show
    @application = Application.find(params[:id])
    Application.search_pet(params[:search_pet])
  end

  def create
    @application = Application.create(application_params)
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :name_of_pet, :application_status)
  end
end
