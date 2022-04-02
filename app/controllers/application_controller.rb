class ApplicationController < ActionController::Base
  def welcome
  end

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    # binding.pry
    @application = Application.create!(application_params)
    redirect_to "/applications/#{@application.id}"
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
