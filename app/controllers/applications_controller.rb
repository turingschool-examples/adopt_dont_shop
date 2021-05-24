class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    desired_pets = PetApplication.where('application_id = ?', @application.id)
    @pet_apps = desired_pets.map do |pet_application|
      Pet.find(pet_application.pet_id)
    end.uniq
  end

  def new
  end

  def create
    @application = Application.create(application_params)

    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:id, :name, :state, :city, :zip_code, :address)
  end
end
