class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    if params[:application_pet_id] && params[:status]
      application_pet = ApplicationPet.find(params[:application_pet_id])
      application_pet.update(status: params[:status])
    end
    if application.all_pets_approved?
      application.update(status: "Approved")
      application.pets.each {|pet| pet.update(adoptable: false)}
    elsif application.any_pets_rejected? && application.all_pets_have_ruling?
      application.update(status: "Rejected")
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end
