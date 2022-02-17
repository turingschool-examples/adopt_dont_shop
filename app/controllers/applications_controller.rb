class ApplicationsController < ApplicationController

  def index
    @application = application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.sorted(params[:search])
    elsif params[:add_pet]
      @application.pets << Pet.find(params[:add_pet])
      @pets = @application.pets
    else
      @pets =[]
    end
  end

  def new
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

  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    @application.Pending!
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
