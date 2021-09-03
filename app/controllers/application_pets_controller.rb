class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.create(app_pet_params)
    flash[:success] = "Pet Added"

    redirect_to application_path(params[:application_id])
  end

  def destroy
  end

  private

  def app_pet_params
    params.permit(:application_id, :pet_id)
  end
end
