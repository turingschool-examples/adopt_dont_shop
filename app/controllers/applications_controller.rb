class ApplicationsController < ApplicationController
  def index    
  end
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end
  
  def create
    application = Application.create!(applications_params)
    # binding.pry
    redirect_to "/applications/#{application.id}"
  end

  private
  def applications_params
    params.permit(:name, :address_street, :address_city, :address_state, :address_zip_code, :description, :status)    
  end
 
end
