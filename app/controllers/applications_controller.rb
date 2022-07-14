class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    app = Application.create!(application_params)

    redirect_to "/applications/#{app.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
