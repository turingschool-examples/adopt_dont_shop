class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:application_id])
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zip_code}"
  end

  def new
  end

  def create
    new_application = Application.new(application_params)
    new_application.save

    redirect_to "/applications/#{new_application.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end