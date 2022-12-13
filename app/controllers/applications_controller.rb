class ApplicationsController < ApplicationController
    
  def show 
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:notice] = "Application not created. Please complete all fields."
    end
  end
  
  def update
    application = Application.find(params[:id])
    application.update(status: "Pending", description: params[:description])
      redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end  
end