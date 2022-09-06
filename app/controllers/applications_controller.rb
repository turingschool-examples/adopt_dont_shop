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

    if application.save
      redirect_to "/applications/#{application.id}"
    end
  end

  def application_params
    params.permit(:id, :name, :address, :about, :status)
  end
end
