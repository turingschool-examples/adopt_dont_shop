class ApplicationController < ActionController::Base
  def welcome
  end

  def index
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_names = @pets.select(:name)
  end

  def new
  end

  def create
    application = Application.create!(application_params)
    redirect_to "/applications/#{Application.last.id}"
  end

  private

  def application_params
    params.permit(:applicant_name, :app_street, :app_city, :app_state, :app_zip_code, :description)
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
