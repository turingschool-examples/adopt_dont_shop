class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.create(app_params)

    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

  def app_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description)
  end
end
