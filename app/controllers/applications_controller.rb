class ApplicationsController < ApplicationController
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
    application_new = Application.create(app_params)

    if application_new.save
      redirect_to "/applications/#{application_new.id}"
    else
      # flash[:alert] = "Error: #{error_message(application.errors)}"
      flash[:error] = "Error: Please fill out all fields"
      redirect_to "/applications/new"
    end
  end

  private
    def app_params
      params.permit(:name, :city, :address, :state, :zipcode, :rationale, :status, :id)
    end
end
