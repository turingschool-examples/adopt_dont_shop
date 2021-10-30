class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def index
  end

  def new
  end

  def create
    if (app_params[:name] != nil) and (app_params[:street_address] != nil) and (app_params[:city] != nil) and (app_params[:state] != nil) and (app_params[:zip_code] != nil)
      application = Application.create(app_params)
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: Please fill out all required information"
      render :new
    end
  end

  private

    def app_params
      params.permit(:name, :street_address, :city, :state, :zip_code)
    end
end
