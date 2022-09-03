class PetApplicationsController < ApplicationController
  def create
    @pet_application = PetApplication.create(pet_applications_params)
    redirect_to "/applications/#{@pet_application.application_id}"
  end

private

  def pet_applications_params
    params.permit(:pet_id, :application_id)
  end
end
