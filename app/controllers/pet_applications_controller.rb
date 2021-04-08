class PetApplicationsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @application.pet_applications.create(pet_id: params[:pet_id])
    redirect_to "/applications/#{@application.id}"
  end
end
