class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}/show"
    else
      redirect_to '/applications/new'
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:id, :name, :state, :city, :zip_code, :address, :description, :status)
  end
end