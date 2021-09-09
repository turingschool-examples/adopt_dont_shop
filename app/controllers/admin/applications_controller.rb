class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end


  def update
    application = Application.find(params[:id])
    application_pets = ApplicationPet.find_by_ids(params[:pet_id], params[:application_id])
    if params[:approved].present?
      application_pets.update({status: "Approved"})
    else
      application_pets.update({status: "Rejected"})
    end

    redirect_to "/admin/applications/#{application.id}"
  end
end
