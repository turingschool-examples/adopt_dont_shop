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
  end


  private

  def application_params
    params.require(:application).permit(:applicant_name, :applicant_street_address, :applicant_city, :applicant_state, :applicant_zip_code, :description, :status)
  end

end
