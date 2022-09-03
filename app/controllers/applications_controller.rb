class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
    end
  end

  def new  
  end

  def create
    application = Application.create(application_params)
    application.status = "In Progress"
    application.save
    redirect_to "/applications/#{application.id}"
  end
  
private
  def application_params
    params.permit(:first_name, :last_name, :str_address, :city, :state, :zip_code, :home_description, :status)
  end
end