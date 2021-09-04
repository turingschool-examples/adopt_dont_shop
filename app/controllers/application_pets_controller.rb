class ApplicationPets < ApplicationController
  def show
    @application_pets = ApplicationPets.find(params[:id])
  end
end
