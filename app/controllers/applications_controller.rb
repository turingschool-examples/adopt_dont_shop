class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def new
  end

  def show
     # binding.pry
    @application = Application.find(params[:id])
  end

  def create
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end


end
