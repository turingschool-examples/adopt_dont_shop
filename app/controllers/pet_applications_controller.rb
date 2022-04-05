class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(pet_id: params[:pet_id], application_id: params[:application_id])
    redirect_to "/applications/#{params[:application_id]}"
  end
end
