class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.create!(application_id: params[:application_id], pet_id: params[:pet_id])
    application = Application.find(params[:application_id])
    application.status_update
    redirect_to "/applications/#{params[:application_id]}"
  end
end