class PetApplicationsController < ApplicationController

  def create
    PetApplication.create!(pet_application_params)
    redirect_to "/applications/#{params[:application_id]}"
  end

private
  def pet_application_params
    params.permit(
      :pet_id,
      :application_id
    ).merge(status: 'Pending')
  end

end