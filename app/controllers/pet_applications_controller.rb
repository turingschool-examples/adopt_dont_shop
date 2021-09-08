class PetApplicationsController < ApplicationController

  def create
    app = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])

    app.pets << pet
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    pet_app = PetApplication.where(pet_id: params[:pet_id], application_id: params[:application_id]).first
    pet = Pet.find(params[:pet_id])

    if params[:reject].present?
      pet_app.update(status: "rejected")
    elsif params[:approve].present?
      pet_app.update!(status: "approved")
    end

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
