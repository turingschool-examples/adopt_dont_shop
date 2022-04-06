class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(pet_id: params[:pet_id], application_id: params[:application_id])
    redirect_to "/applications/#{params[:application_id]}"
  end
  
  def update
    pet_app = PetApplication.find(params[:id])
    pet_app.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:application_id]}" 
  end
end
