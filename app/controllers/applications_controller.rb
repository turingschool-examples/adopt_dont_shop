class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pet_search = Pet.adoptable.search(params[:search])
    else
      @pets = []
    end
  end

  def create
    @application = Application.new(applications_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def new
  end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_application = PetApplication.new(pet_id: @pet.id, application_id: @application.id)
    if @pet_application.save
      redirect_to "/applications/#{@application.id}"
    end
  end

  private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
