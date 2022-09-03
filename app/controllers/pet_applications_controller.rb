class PetApplicationsController < ApplicationController

  def create
    # @application = Application.find(application_id)
    # require "pry"; binding.pry
    @petapplication = PetApplication.create(pet_applications_params)
    redirect_to "/applications/#{@petapplication.application_id}"
  end


end

private

def pet_applications_params
  params.permit(:pet_id, :application_id)
end
