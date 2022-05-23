class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @search_results = Pet.search(params[:search]) if params[:search]
    if params[:adopt] == "adoption"
      @pets << @search_results
    end
  end

  def new
  end

  def update
    @application = Application.find(params[:id])
    @pets = @application.pets
    # require "pry"; binding.pry
    if params[:pet]
      pet = Pet.find(params[:pet])
      @pets << pet
    end
    redirect_to "/applications/#{@application.id}"
  end

  def create
    application_new = Application.create(app_params)

    if application_new.save
      redirect_to "/applications/#{application_new.id}"
    else
      flash[:error] = "Error: Please fill out all fields"
      redirect_to "/applications/new"
    end
  end

  private
    def app_params
      params.permit(:name, :city, :address, :state, :zipcode, :rationale, :status, :id)
    end
end
