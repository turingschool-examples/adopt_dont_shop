class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new

  end

  def create
    application = Application.new(app_params)
    
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      render :new
    end
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end