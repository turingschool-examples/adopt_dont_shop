class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.get_pets
  end

  def create
    application = Application.new(application_params)
  end
end

private

def application_params
  params.permit(:id, :name, :address, :city, :state, :zip_code, :description, :status, :shelter_id)
end
