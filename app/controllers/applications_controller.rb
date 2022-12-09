class ApplicationsController < ApplicationController

  def show
    @application_pets = ApplicationPet.where(application_id: params[:id])
    # refactor into model ^^
    @application = Application.find(params[:id])
    # @pets = Pet.where(the pet's id matches pet_id on application_pets )
  end
end