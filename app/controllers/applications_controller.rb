class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
    @application = Application.new
  end

  def create
    # binding.pry
    @application = Application.create(application_params)
    redirect_to "/applications/#{@application.id}"
  end


  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
