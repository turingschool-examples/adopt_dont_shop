class ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
  end

  def new
  end

  def create
    app = Application.create(app_params)
    redirect_to "/applications/#{app.id}"
  end

private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
