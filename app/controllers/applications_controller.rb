class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:application_id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = nil
    end

    
  end

  def new
  end

  def create
    @application = Application.create!(application_params)
    
    redirect_to "/applications/#{@application.id}"
  end

  def update
    @application = Application.find(params[:application_id])
    @application.update(application_params)
    redirect_to "/applications/#{@application.id}"
  end




private
  def application_params
    params.permit(:name, 
                  :street_address, 
                  :city, 
                  :state, 
                  :zip_code, 
                  :description,
                  :status)
  end
end