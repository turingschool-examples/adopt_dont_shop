class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    # require 'pry'; binding.pry
    # @application = Application.find(params[:id])

    # @application = Application.find(application_params)
  end

  def create
    # require 'pry'; binding.pry
    application = Application.create!(application_params)
    # require 'pry'; binding.pry
    # application.update(status: "Pending")
    # Application.update_attributes(:status => "In Progress")
    # application.update_attributes :status => "In Progress"
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :id)
  end
end