class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(permitted_params[:id])
    @application_pets = @application.pets
  end

  def update
    application_pet = ApplicationPet.find_by(pet_id: permitted_params[:pet_id], application_id: permitted_params[:id])
    if permitted_params[:status] == "Approved"
      application_pet.update(status: 'Approved')
    else
      application_pet.update(status: 'Rejected')
    end
    redirect_to "/admin/applications/#{application_pet.application.id}"
  end

  private
  def permitted_params
    params.permit(:id, :pet_id, :status)
  end
end
