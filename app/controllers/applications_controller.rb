class ApplicationsController < ApplicationController
  def welcome
  end

  def index
    @applications = Application.all
  end

  def new

  end

  def create
    Application.create(application_params)
    redirect_to '/applications'
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end


end
