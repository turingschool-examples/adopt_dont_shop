class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application_pets = []
    @pets.each do |pet|
      @application_pets << ApplicationPet.find_by_pet_and_app(pet.id, params[:id])
    end
    if params[:pet_id]
      @application_pet = ApplicationPet.find(params[:app_pet_id])
      @application_pet.approve
      pet = Pet.find(params[:pet_id])
      pet.adopt
      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:reject_pet_id]
      @application_pet = ApplicationPet.find(params[:app_pet_id])
      @application_pet.reject
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end