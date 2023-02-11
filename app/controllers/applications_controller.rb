class ApplicationsController < ApplicationController

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
    application = Application.new(application_params)
    if application.valid?
      application.save     
      redirect_to "/applications/#{application.id}"
    else
      flash.now[:messages] = application.errors.full_messages
      render :new
    end
  end

  private

  def application_params
    params.permit(:applicant_name, :app_street, :app_city, :app_state, :app_zip_code, :description)
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
