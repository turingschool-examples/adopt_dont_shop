class PetApplicationsController < ApplicationController

  def new
  end
  
  def show
    @application = Application.find(params[:id])
    @pending_pets = PetApplication.pending_pets
    @pet_application = PetApplication.find(params[:application_id])
  end

  def create
    @applied_pet = Pet.find_pet_by_id(params[:pet_id])
    @progress_application = Application.find_desired_application(params[:application_id])
    @pet_application = PetApplication.create!(pet: @applied_pet.first, application: @progress_application.first)
    redirect_to "/applications/#{@progress_application.first.id}"
  end

  def update
    @application = Application.find(params[:application_id])
    @pet_application = PetApplication.find(params[:application_id])
    if params[:status] == "approved"
      @pet_application.pet_application_status = "Approved"
      @pet_application.save
      redirect_to "/admin/applications/#{@application.id}"
    elsif 
      require 'pry' ; binding.pry
      @pet_application.save
      redirect_to "/admin/applications/#{@application.id}"
    end
  end


end