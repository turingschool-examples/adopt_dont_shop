class ApplicationPetsController < ApplicationController
  def create
    app_pet = ApplicationPet.create(app_pet_params)
    redirect_to "/applications/#{app_pet_params[:application_id]}"
  end

  private
    def app_pet_params
      params.permit(:id, :pet_id, :application_id)
    end
end
