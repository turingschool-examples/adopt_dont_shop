class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pending_pets = PetApplication.pending_pets
  end


end