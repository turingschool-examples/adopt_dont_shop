class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @admin = params[:admin]
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else 
      @pets = Pet.adoptable
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Please fill all fields"
      redirect_to '/applications/new'
    end
  end

  private
  def application_params
    params.permit(:name, :address_street, :address_city, :address_state, :address_zip_code, :description, :status)
  end
end
