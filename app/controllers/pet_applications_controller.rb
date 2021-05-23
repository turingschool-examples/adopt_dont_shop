# app/controllers/pet_applications_controller

class PetApplicationsController < ApplicationController

  def edit 
    application = Application.find(params[:applications_id])
  end
  
  def add_pet
    application = Application.find(params[:applications_id])
    application.pets << Pet.find(params[:pet_id])

    redirect_to "/applications/#{application.id}"
  end
end