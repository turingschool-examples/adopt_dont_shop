class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(pet_id: params[:pet], application_id: params[:application])
    redirect_to "/applications/#{params[:application]}"
  end
end