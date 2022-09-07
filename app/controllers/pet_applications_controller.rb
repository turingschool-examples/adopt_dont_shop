class PetApplicationsController < ApplicationController


  def associate_pet_app
    app = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    if !app.pets.include?(pet)
      app.pets << pet
    end
    redirect_to "/applications/#{params[:id]}"
  end

  def admin_update
    search_hash = {pet_id: params[:pet_id], application_id: params[:id]}
    pet_app_record = PetApplication.where(search_hash).first
    application = Application.find(params[:id])
    pet_app_record.update(app_pet_params)
    if pet_app_record.application_complete?(application.id)
      pet_app_record.complete_application(application)
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def app_pet_params
    params.permit(:pet_status)
  end
end