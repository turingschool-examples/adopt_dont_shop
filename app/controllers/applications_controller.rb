class ApplicationsController < ApplicationController

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = search
  end

  def search
    Pet.search(params[:search])
  end

  private
    def application_params
      params.permit(:id, :name, :address, :city, :state, :zip, :description, :status, :search)
    end
end
