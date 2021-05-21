class ApplicationsController < ApplicationController

  def create
    application = Application.create!(application_params)
    redirect_to "/applications/#{application.id}"
  end

  def new
  end

  def show
    @application = Application.find(params[:id])
  end

  private
  def application_params
    params.permit(:name,
                  :street_address,
                  :city,
                  :state,
                  :zip_code,
                  :status)
    end
end