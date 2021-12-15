class ApplicationsController < ApplicationController
  def show
    # require "pry"; binding.pry
    @applications = Application.find(params[:id])
  end

  def new

  end

  def create
    # require "pry"; binding.pry
    @application = Application.create!(application_params)

    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end
end