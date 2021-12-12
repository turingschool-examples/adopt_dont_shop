class PetApplicationsController < ApplicationController
  def create
    pet_app = PetApplication.create(pet_app_params)
    redirect_to "/applications/#{pet_app.application_id}"
  end

  private

    def pet_app_params
      params.permit(:application_id, :pet_id)
    end
end