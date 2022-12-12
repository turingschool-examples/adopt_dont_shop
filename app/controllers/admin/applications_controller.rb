class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @application_pets needs to be defined here?
    @pets = @application.pets
    @application_pets = []
    @pets.each do |pet|
      @application_pets << ApplicationPet.find_by_pet_and_app(pet.id, params[:id])
      # require 'pry'; binding.pry
    end
    if params[:pet_id]
      @application_pet = ApplicationPet.find_by_pet_and_app(params[:pet_id], params[:id])
      @application_pet.approve
      pet = Pet.find(params[:pet_id])
      pet.adopt
      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:reject_pet_id]
      @application_pet = ApplicationPet.find_by_pet_and_app(params[:reject_pet_id], params[:id])
      @application_pet.reject
      redirect_to "/admin/applications/#{@application.id}"
    # else
    #   @application_pet = ApplicationPet.find_by_pet_and_app(params[:reject_pet_id], params[:id])
    #   @status = @application_pet.approved
    end
  end
end