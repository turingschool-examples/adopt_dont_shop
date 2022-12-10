class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  # def update
  #   application = Application.find(params[:id])
  # end

  def create
    application = Application.new(application_params)
    if application.name == "" || application.street_address == "" || application.city == "" || application.state == "" || application.zip_code == ""
      redirect_to "/applications/new"
      flash[:alert] = "Error: Please fill in all fields"
      # application.update(status: "In Progress")
    else
      redirect_to "/applications/#{application.id}"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :id)
  end
end