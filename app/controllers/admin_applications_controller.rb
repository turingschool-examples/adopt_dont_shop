class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application_pet = ApplicationPet.find_by(application_id: params[:id], pet_id: params[:pet_id])
    @application_pet.update(accept: params[:approve_reject])
    @application_pet.save
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private
  def application__pet_params
    params.permit(:application_id, :pet_id, :accept)
  end

  private
  def error_message(errors)
    errors.full_messages.join(', ')
  end
end