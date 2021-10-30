class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end 

  def update 
    binding.pry
    app_pet = ApplicationPet.where(pet_id: params[:pet_id], application_id: params[:app_id])
    if params[:commit].include? "Approve"
      app_pet.update(status: "Approved")
    else 
      app_pet.update(status: "Rejected")
    end 
    redirect_to "/admin/applications/#{params[:app_id]}"
  end
end 