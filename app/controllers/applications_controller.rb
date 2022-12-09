class ApplicationsController < ApplicationController

  def new

  end

  def create
    application = Application.create!(application_params)
    # binding.pry
    redirect_to "/applications/#{application.id}"
  end

  def show
    @application = Application.find(params[:id])
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end