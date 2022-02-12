class ApplicationsController < ApplicationController
  def show
    @applicant = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      redirect_to "/applications/new"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
