class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
    if params[:commit] == "Search"
      @search_pets = Pet.search(params[:pet_search])
    end
  end
 
  def new 

  end

  def create 
    application = Application.create(application_params)
    # redirect_to "/applications/#{application.id}"

    if application.save 
    redirect_to "/applications/#{application.id}"
    
    else
      render '/applications/new'
    end
  end

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :status, :description)
  end
end