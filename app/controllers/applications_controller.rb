class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
    
  end

  def create
    app = Application.create(application_params)
    redirect_to "/applications/#{app.id}"
  end
  def update
    application = Application.find(params[:id])
    application.update(application_params)
    redirect_to "/applications/#{application.id}"
    application.change_status_to_pending
    application.save
  end

  def edit
    @application = Application.find(params[:id])
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status)
  end
end