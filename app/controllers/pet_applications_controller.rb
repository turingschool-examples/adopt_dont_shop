class PetApplicationsController < ApplicationController
  def create
    pet = Pet.find(params[:id])
    application = Application.find(params[:application_id])
    redirect_to "/applications#{application.id}"
  end
end
