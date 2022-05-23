class PetApplicationsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create

  def create
    binding.pry
    @application = Application.find(params[:application_id])
    @pet_application = PetApplication.create(application_id: params[:application_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:application_id]}"
  end


  def update
    pet_application = PetApplication.find(params[:application_id])
    pet_application.status_pending
    redirect_to "/applications/#{params[:application_id]}"
  end


  private

  def pet_application_params
    params.permit(:pet_id, :application_id)
  end

end
