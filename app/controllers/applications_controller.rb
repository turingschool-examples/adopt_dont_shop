class ApplicationsController < ApplicationController

  def show
      @application = Application.find(params[:id])
  end
  
  def new
  end

  def create
    new_app = Application.new(application_params)
    if new_app.save
      new_app.update(status: "In Progress")
      redirect_to "/applications/#{new_app.id}"
    else
      flash[:notice] = "Application not Submitted. Please fill out all fields."
      redirect_to("/applications/new")
    end 
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end