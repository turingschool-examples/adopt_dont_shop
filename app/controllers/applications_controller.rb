class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @adoption_pet = []
    @pets = []
    @application = Application.find(params[:id])
    if params[:search_by_name].present?
      @application
      @pets = @application.search_by_name_threshold(params[:search_by_name])
    else
      @application
    end
    if params[:adoption].present?
      @adoption_pet = @adoption_pet.push(Pet.find(params[:adoption]))
      @application.adoption_threshold(@application, params[:adoption])

    else
      @adoption_pet
    end
  end

  def edit

  end

  def new
  end
  def create
    adoption = Application.new(app_params)
    if adoption.save
      redirect_to "/applications/#{adoption.id}"
    else
      flash[:notice] = "Application not complete: Please fill out all sections"
      render :new
    end
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
