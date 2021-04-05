class ApplicationPetsController < ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    app = Application.find(params[:id])
    app_pet = ApplicationPet.find_or_create_by!(pet: pet, application: app)
    binding.pry 
    redirect_to "/applications/#{app.id}"
  end
end
