class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(app_params)
    if application.save
      flash[:success] = 'Application was successfully created.'
      redirect_to application_path(application)
    else
      flash[:error] = 'Application could not be created. Do better'
      redirect_to new_application_path
    end
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end
end
