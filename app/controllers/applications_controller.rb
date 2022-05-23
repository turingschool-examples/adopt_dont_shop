class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    else
      @pets = @application.show_pets
    end
    if @application.pets.empty?
      @pets_added = false
    else
      @pets_added = true
    end

  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def adopt_pet
    @application = Application.find(params[:id])
    if params[:pet_id]
      PetApplication.create!(pet_id: params[:pet_id], application_id: params[:id])
    end
    redirect_to "/applications/#{@application.id}"
  end

  def update
    application = Application.find(params[:id])
    application.update(description: params[:description], application_status: "Pending")
    redirect_to "/applications/#{application.id}"
  end
  private

  def application_params
    params.permit(:id, :name, :street, :city, :state, :zip, :description,
    :application_status)
  end
end
