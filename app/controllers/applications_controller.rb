class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @applicant = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.create(application_params)

    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.require(:application).permit(:name, :description, :status, address: [:street, :city, :state, :zip])
  end
end
