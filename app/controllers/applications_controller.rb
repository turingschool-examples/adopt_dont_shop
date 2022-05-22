class ApplicationsController < ApplicationController

  def show
    @applications = Application.find(params[:id])
  end

  def index
    @applications = Application.all
  end

  def new

  end

  def create
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end


  private

    def application_params
      params.permit(:name, :street_address, :city, :state, :zip)
    end
end
