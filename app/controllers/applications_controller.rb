class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:search])
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def edit
  end

  def update
    application = Application.find(params[:id])
    if application.update(update_params)
      redirect_to application_path(application.id)
    else
      redirect_to application_path
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end


  private

  def application_params
    params.require(:application).permit(:applicant_name, :applicant_street_address, :applicant_city, :applicant_state, :applicant_zipcode, :description, :status)
  end

  def update_params
    params.permit(:applicant_name, :applicant_street_address, :applicant_city, :applicant_state, :applicant_zipcode, :description, :status)
  end
end
