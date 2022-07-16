class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end 
  end

  def new 

  end

  def create
    params[:address] = "#{params[:street_address]}, #{params[:city]}, #{params[:state]} #{params[:zip_code]}"
    application = Application.create(application_params)

    redirect_to "/applications/#{application.id}"
  end
  
  private 
  def application_params 
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status, :search)
  end
end
