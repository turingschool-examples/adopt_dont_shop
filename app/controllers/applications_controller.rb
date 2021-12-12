class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def new
  end

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = @application.pets
      
      # @pets = Pet.search(params[:search])
    end
  end

  def create
    application = Application.create(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error"
      redirect_to "/applications/new"
    end
    # binding.pry

  end

private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end


end
