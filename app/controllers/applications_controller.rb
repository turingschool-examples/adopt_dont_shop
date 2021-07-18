class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def new
    # @application = Application.find(params[:application_id])
  end

  def create
    application = Application.create!(application_params)
  end

private
  def application_params
    params.permit(:id, :name, :street, :city, :state, :zip_code, :application_status, :description)
  end


end
