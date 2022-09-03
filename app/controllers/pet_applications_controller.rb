class PetApplicationsController < ApplicationController

  def create
    @application = Application.find(params[:id])
    @petapplication = PetApplications.create(pet_applications_params)
    redirect_to "applications/#{@application.id}"
  end


end

private

def pet_applications_params
  params.permit(:pet_id, :application_id)
end
