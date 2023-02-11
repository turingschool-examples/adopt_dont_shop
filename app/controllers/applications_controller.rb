class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params.merge({status: "In Progress"}))
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      redirect_to "/applications/new"
    end  
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end