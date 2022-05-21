class ApplicationFormsController < ApplicationController

  def index
    @application_forms = ApplicationForm.all
  end

  def show
    @application_form = ApplicationForm.find(params[:id])
  end

  def new
  end

  def create
    application_form = ApplicationForm.new(application_form_params)
    application_form.status = "In Progress"
    if application_form.save
      redirect_to '/application_forms/'
    else
      redirect_to '/shelters/new'
      flash[:alert] = "Error: #{error_message(shelter.errors)}"
    end

    # if shelter.save
    #   redirect_to '/shelters'
    # else
    #   redirect_to '/shelters/new'
    #   flash[:alert] = "Error: #{error_message(shelter.errors)}"
    # end
  end

  private
    def application_form_params
      params.permit(:name, :street_address, :city, :state, :zip_code)
    end

end
