class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    end
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

  def update
    application = Application.find(params[:id])
    if application.update(app_params)
      redirect_to application_path(application)
    else
      flash[:error] = 'Application could not be submitted'
      redirect_to application_path(application)
    end
  end 

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end
end
