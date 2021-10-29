class ApplicationPetsController < ApplicationController

  def create
    @application = Application.find(params[:application_id])
    @application.add_pet(params[:pet_id])
    redirect_to application_path(@application)
  end

  def update
    application_pet = ApplicationPet.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
    if params[:status] == 'Approve'
      application_pet.update(status: 'Approved')
      redirect_to admin_application_path(params[:application_id])
    elsif params[:status] == 'Reject'
      application_pet.update(status: "Rejected")
      redirect_to admin_application_path(params[:application_id])
    else
      flash[:alert] = 'Unable to update'
      redirect_to admin_application_path(params[:application_id])
    end
  end
end
