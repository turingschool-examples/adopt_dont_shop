class ApplicationPetsController < ApplicationController
  def create
    binding.pry
    pet = Pet.find(params[:pet_id])
    app = Application.find(params[:id])

    ApplicationPet.create!(pet: pet, application: app)

    # redirect_to 
  end
end
