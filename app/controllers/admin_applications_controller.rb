class AdminApplicationsController < ApplicationController
  def show
    @application_pets = ApplicationPet.where(application_id: params[:application_id])
    @application = Application.find(params[:application_id])
  end
end