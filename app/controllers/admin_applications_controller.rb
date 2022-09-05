class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pending_pets = PetApplication.pending_pets
    @pet_application = PetApplication.where(application_id: params[:id]).first
  end

end