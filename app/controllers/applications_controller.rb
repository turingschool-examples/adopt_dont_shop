class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.pets
    if params[:search].present?
      @found_pets = Pet.search(params[:search])
    else
      @found_pets = []
    end
  end

  def index
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.valid?
      @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:messages] = @application.errors.full_messages
      render :new
    end
  end

  def update
    if params[:description].present? == false
      @application = Application.find(params[:id])
      if params[:pet]
        @pet = Pet.find(params[:pet])
        ApplicationPet.create!(pet: @pet, application: @application)
      end
      redirect_to "/applications/#{@application.id}"
    else 
      @application = Application.find(params[:id])
      @application.description = params[:description]
      @application.app_status = 1
      @application.save
      redirect_to "/applications/#{@application.id}"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :app_status, :pets_on_app, :search)
  end
end