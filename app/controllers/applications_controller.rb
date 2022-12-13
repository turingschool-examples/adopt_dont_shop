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
    application = Application.new(application_params)
    
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    @application = Application.find(params[:application_id])
    @application.update(application_params)

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/#{@application.id}"
      flash[:alert] = "Error: You must provide a description"
    end
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