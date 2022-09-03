class PetApplicationsController < ApplicationController

  def new
  end

  def create
    @applied_pet = Pet.find_pet_by_id(params[:pet_id])
    @progress_application = Application.find_desired_application(params[:application_id])
    @pet_application = PetApplication.create!(pet: @applied_pet.first, application: @progress_application.first)
    redirect_to "/applications/#{@progress_application.first.id}"
  end


end