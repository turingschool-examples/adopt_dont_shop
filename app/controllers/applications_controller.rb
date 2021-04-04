class ApplicationsController < ApplicationController

  def create
    @application.new(application_params)
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:id, :name, :address, :description, :status)
  end

end