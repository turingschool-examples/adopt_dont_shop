class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def create
    @application = Application.create!(applications_params)
  end

  def new
  end

  private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
