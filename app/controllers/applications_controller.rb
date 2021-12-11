class ApplicationsController < ApplicationController
  def index
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    application = Application.create(application_params)

    redirect_to "/applications/#{application.id}"
  end

private

def application_params
  params.permit(:name, :street, :city, :state, :zip)
end
end
