class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search_by_name(params[:pet_name])
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      redirect_to "/applications/new"
    end  
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end