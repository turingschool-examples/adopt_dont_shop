class ApplicationsController < ApplicationController
 
  def show
    @application = Application.find(params[:id])
    @pets = Application.find_associated_pets
  end

  def new
  end

  def create
    @application = Application.create(application_params)
    redirect_to "/applications/#{@application.id}"  
    #step 4 directing the user to a diff page
  end

  private
  def application_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip_code, :description, :status)
  end

end
