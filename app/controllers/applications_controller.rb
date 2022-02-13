class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      redirect_to "/applications/new"
    end
  end

  def search
    # @pet = Pet.search(params[:search_pet_by_name])
    redirect_to action: :show
  end

  def update
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    if application.add_pet?(pet)
    # pet_application = PetApplication.new(pet_id: @pet.id, application_id: @application.id)
    # if pet_application.save
      redirect_to action: :show
    else
      flash[:alert] = "Error: you are already adopting this pet"
      redirect_to action: :show
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
