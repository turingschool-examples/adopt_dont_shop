class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    new_app = Application.create(app_params)
    redirect_to "/applications/#{new_app.id}"
  end

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :status)
  end
end
