class ApplicationsController < ApplicationController
  @@counter = 0
  def initialize
    @adoption_pets = []
    @pets = []
  end
  def index
    @applications = Application.all
  end

  def show
    if @@counter == 0
      @application = Application.find(params[:id])
      if params[:search_by_name].present?
        @application
        @pets = @application.search_by_name_threshold(params[:search_by_name])
      else
        @application
      end
      if params[:adoption].present?
        @adoption_pets = @adoption_pets.push(Pet.find(params[:adoption]))
        @application.adoption_threshold(@application, params[:adoption])
      end
    else
      @application = Application.find(params[:id])
      @app_pets = AdoptablePet.where(application_id: @application.id)
      @adoption_pets = @app_pets.map{|pet| Pet.find(pet.pet_id)}
    end
  end

  def edit

  end

  def update
    @application = Application.find(params[:id])
    @application.update(app_params)
    @@counter += 1
    redirect_to "/applications/#{@application.id}"
  end

  def new
    @@counter = 0
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
