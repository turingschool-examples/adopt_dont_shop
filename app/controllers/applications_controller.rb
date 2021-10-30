class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets_found = Pet.search(params[:pet_name])
    end
  end

  def index
  end

  def new
  end

  def create
    application = Application.new(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: Please fill out all required information"
      redirect_to "/applications/new"
    end

  end

  private

    def app_params
      params.permit(:name, :street_address, :city, :state, :zip_code)
    end
end
