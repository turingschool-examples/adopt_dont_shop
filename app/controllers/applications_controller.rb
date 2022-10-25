class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
    @app_pets = @application.application_pets

    @application_pets = ApplicationPet.where("application_id = #{@application.id}")
  end

  def new
  end
  

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else 
      flash[:alert] = "Unable to complete your application, please fill out all fields"
      redirect_to "/applications/new"
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    if params[:pet].present?
      @pet = Pet.find(params[:pet])
      ApplicationPet.create!(application: @application, pet: @pet)
    end
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip, :status, :description)
  end
end