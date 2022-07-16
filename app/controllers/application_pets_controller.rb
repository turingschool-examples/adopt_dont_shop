class ApplicationPetsController < ApplicationController
  def create
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet])
    ApplicationPet.create!(application: @application, pet: @pet)
  end
end
