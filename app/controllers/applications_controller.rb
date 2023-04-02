class ApplicationsController < ApplicationController

  def index
  end
  
  def show
    @application = Application.find(params[:id])
    @searched_pets = Pet.search(params[:search_pet]) if !params[:search_pet].nil?
  end

  def create
    @application = Application.create(application_params)
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    redirect_to "/applications/#{@application.id}"
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :name_of_pet, :application_status)
  end
end