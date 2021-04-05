class ApplicationsController < ApplicationController

  def create
    @application.new(application_params)
  end

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def edit
    @application = Application.find(params[:id])
  end

  def new
  end

  def update
  end

  private

  def application_params
    params.permit(:id, :name, :address, :description, :status)
  end

end