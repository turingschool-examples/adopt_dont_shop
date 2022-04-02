class ApplicationsController < ApplicationController

  def index

  end

  def show
    @application = Application.find(params[:application_id])
    @pets = Pet.all
  end

  def new
    # @application = Application.find(params[:id])
  end

  def create
    @application = Application.create(application_params)
    redirect_to "/applications/#{@application.id}"
  end


  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description)
  end

end
