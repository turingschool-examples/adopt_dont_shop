class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet = Pet.find_by_name(params[:pet_name])
  end

  def new; end

  def create
    application = Application.create!(application_params)
    redirect_to "/applications/#{application.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :city,
                  :state, :zipcode, :description, :status)
  end
end
