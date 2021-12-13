class PetApplicationsController < ApplicationsController

  def new

  end

  def create
    @pet_applications = PetApplication.create(pet_application_params)
    redirect_to "/applications/#{@pet_applications.application_id}"
  end

private
  def pet_application_params
    params.permit(:application_id, :pet_id)
  end
end
