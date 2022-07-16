class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.create(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  # def create
  #   pet = Pet.new(pet_params)
  #
  #   if pet.save
  #     redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
  #   else
  #     redirect_to "/shelters/#{pet_params[:shelter_id]}/pets/new"
  #     flash[:alert] = "Error: #{error_message(pet.errors)}"
  #   end
  # end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
