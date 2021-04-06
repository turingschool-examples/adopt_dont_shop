class ApplicationsController < ApplicationController

  def new
  end

  def create
    application = Application.new(application_params)
    application.update_attribute(:status, "In progress")

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      redirect_to applications_new_url
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:search])
  end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find_by_name(params[:pet_name])
    PetApplication.create!(application: @application, pet: @pet)
    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:id, :name, :address, :description, :status)
  end

end
