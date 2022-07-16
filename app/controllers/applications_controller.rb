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
    application = Application.new(application_params)
    if application.save 
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new', notice: "Please fill in all fields."
    end 
  end
  
  private 
  def application_params 
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status, :search)
  end
end
