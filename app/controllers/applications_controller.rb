class ApplicationsController < ApplicationController

  def index
  end

  def new
  end

  def create
    application = Application.new(app_params)
    #redirect_to show
  end

  private

  def app_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code)
  end
end
