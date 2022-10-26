class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets_and_approval = @application.pets_in_application_to_approve
    @approval_hash = { true => "Approved", false => "Rejected" }
  end

  def update
    @application_pet = ApplicationPet.find_by(application_id: params[:id], pet_id: params[:pet_id])
    @application_pet.update(accept: params[:approve_reject])
    @application_pet.save
    redirect_to "/admin/applications/#{params[:id]}"
  end
end