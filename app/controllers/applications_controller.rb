class ApplicationsController < ApplicationController

  def index
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.create(application_params)
    application.save
  end

  def application_params
    params.permit(:name,
                  :street_address,
                  :city,
                  :state,
                  :zip_code,
                  :description,
                  :status)
  end
end
