class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.find(@application.pet_id)
  end

  def new
  end

  def create
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

  def application_params
    params.permit(:name, :city, :zip, :street, :status, :state, :description)
  end
end
