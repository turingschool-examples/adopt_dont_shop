class PetsApplicationsController < ApplicationController
  def create
    @pets_applications = PetsApplication.create(pets_application_params)
    redirect_to "/applications/#{@pets_applications.application_id}"
  end

  private
  def pets_application_params
    params.require(:pets_application).permit(:pet_id, :application_id)
  end
end