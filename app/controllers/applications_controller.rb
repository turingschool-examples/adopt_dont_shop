class ApplicationsController < ApplicationController

  def create
    @application = Application.create(application_params)
    redirect_to "/applications/#{@application.id}"
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  private

  def application_params
    params.permit(:id, :name, :address, :description, :status)
  end

end
