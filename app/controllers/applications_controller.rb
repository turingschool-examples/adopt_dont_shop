class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_search = params[:pet_name].present? ? Pet.search(params[:pet_name]) : []
  end

  def add_pet
    @application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    @application.pets << pet
    redirect_to "/applications/#{@application.id}"
  end

  def new

  end

  def create
    if Application.create(application_params).valid?
      @application = Application.create!(application_params)
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Please fill out all fields."
      redirect_to "/applications/new"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description)
  end
end