class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search("%#{params[:search]}%")
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

  def adopt
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    application.add_pet(pet)
    redirect_to "/applications/#{application.id}"
  end

  def update
    application = Application.find(params[:id])
    application.update(application_params)
    redirect_to "/applications/#{application.id}"
  end


  private
    def application_params
      params.permit(
        :name,
        :street_address,
        :city,
        :state,
        :zip,
        :description,
        :status
      )
  end
end