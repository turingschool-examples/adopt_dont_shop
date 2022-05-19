class ApplicationsController < ApplicationController 

  def show
    @application = Application.find(params[:id])
  end
  
  def new
  end
  
  def create 
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to '/applications'
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end


  private 

  def application_params 
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pets, :application_status)
  end
end

