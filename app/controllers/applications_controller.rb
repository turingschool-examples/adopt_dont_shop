class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @applicant = Application.find(params[:id])
    @pets = []
    if params.include?(:search)
      @pets = Pet.search(params[:search])
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.create(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:notice] = "Application not created: Required information missing."
      render 'new'
    end
  end

  def add
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    application.pets << pet
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.require(:application).permit(:name, :description, :status, address: [:street, :city, :state, :zip])
  end
end
