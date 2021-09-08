class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :street, :city, :state, :zip_code)
  end
end
