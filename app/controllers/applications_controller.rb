class ApplicationsController < ApplicationController
  def welcome
  end

  def index
    @applications = Application.all
  end

  def new

  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end

  # def error_message(errors)
  #   errors.full_messages.join(', ')
  # end


end
