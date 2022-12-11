class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @application_pets = @application.application_pets
    @pets = @application.pets
    if params[:pet_id]
      @application_pet = ApplicationPet.find_by_pet_and_app(params[:pet_id], params[:id])
      @application_pet.approve
      @status = @application_pet.approved
      pet = Pet.find(params[:pet_id])
      pet.adopt
    elsif params[:reject_pet_id]
      @application_pet = ApplicationPet.find_by_pet_and_app(params[:reject_pet_id], params[:id])
      @application_pet.reject
      @status = @application_pet.approved
    end
  end
end