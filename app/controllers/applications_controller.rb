class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new

  end

  def create
    application = Application.create!(application_params)

      if application.save
        redirect_to "/applications/#{application.id}"
      # else
      #   redirect_to "/shelters/#{pet_params[:shelter_id]}/pets/new"
      #   flash[:alert] = "Error: #{error_message(pet.errors)}"
      end
  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :description, :status)
    end

end
