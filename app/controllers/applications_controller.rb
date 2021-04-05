class ApplicationsController < ApplicationController
  def index
      @applications = Application.all
  end

  private
  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
