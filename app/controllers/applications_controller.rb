class ApplicationsController < ApplicationController

  def index
  end

  def show
    @app = Application.find(params[:id])
    @pets = @app.list_pets
  end

  def new
  end

  def create
    application = Application.new(application_params)

    redirect_to "/applications/#{application.id}" if application.save
  end

  private
  def application_params
    params.permit(:id, :name, :address, :about, :status)
  end
end
