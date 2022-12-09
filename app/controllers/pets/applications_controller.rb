class Pets::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @adoptees = @application.pets
  end

  def create
    application = Application.create!(create_params)
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

  def create_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
