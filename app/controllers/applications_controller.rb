class ApplicationsController < ApplicationController
  def index
  end

  def new
    @application = Applications.find(params[:id])
  end

  def create
    @application = Applications.create(application_params)
    redirect_to "/applications/#{@application.id}"
  end
  #
  # def show
  #   @application = Applications.find(params[:id])
  # end
  #

  private

  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zipcode)
  end
end
