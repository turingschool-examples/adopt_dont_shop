class ApplicationFormsController < ApplicationController
  def index
    @application_forms = ApplicationForm.all
  end

  def show
    # require "pry"; binding.pry
    @application_form = ApplicationForm.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    else
      @pets = @application_form.pets
    end
  end

  def new
  end

  def create
    application = ApplicationForm.new(application_params)
    if application.save
      flash[:notice] = "Your application has been submitted"
      redirect_to "/application_forms/#{params[:id]}"
    else
      redirect_to "/application_forms/new"
      flash[:notice] = "Your form is not complete"
    end
  end

  def edit
    application_form = ApplicationForm.find(params[:id])
    application_form.pets << Pet.find(params[:data][:pet_id])
    redirect_to "/application_forms/#{params[:id]}"
  end

  def update
    application_form = ApplicationForm.find(params[:id])
    if application_form.update(application_params)
      redirect_to "/application_forms/#{application_form.id}"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
