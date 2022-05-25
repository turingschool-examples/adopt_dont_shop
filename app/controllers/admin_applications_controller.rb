class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @application_pets = ApplicationPets.find(params[:id])
  end

  def edit

  end

  def update
    # require "pry"; binding.pry
    application = Application.find(params[:id])
    application_pet = application.application_pets.find { |pet| pet.pet_id == params[:pet_id].to_i }
    if params[:decision] == "approve"
    application_pet.update(status: "Approved")
  else params[:decision] == "reject"
    application_pet.update(status: "Rejected")
  end
    redirect_to "/admin/applications/#{application.id}"
  end
end
