class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.get_pets
  end

  def index
  end

  def create
    application = Application.create!(application_params)
    redirect_to "/applications/#{application.id}"
  end
end

private

def application_params
  params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
end
