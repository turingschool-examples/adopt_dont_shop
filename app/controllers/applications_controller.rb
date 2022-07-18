class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search].present?
      @search_pets = Pet.search(params[:search])
    else
    end
  end

  def new
    @application = Application.new
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


  def add_pet
    application = Application.find(params[:id])
    pet = Pet.find(params[:add_pet])
    pet_application = PetApplication.create!(application_id: application.id, pet_id: pet.id, status: application.status)
    redirect_to "/applications/#{application.id}"

  def submit
    @application = Application.find(params[:id])
    if @application.status == "In Progress" && @application.has_pets?
      @application.status = "Pending"
      @application.save
    end
    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
