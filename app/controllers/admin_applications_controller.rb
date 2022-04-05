class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app_pet = @application.application_pets
    # require "pry"; binding.pry
  end

  def update
    @application = Application.find(params[:id])
    @app_pet = ApplicationPet.find(params[:app_id])
    if params[:status] == "Approve"
      @app_pet.pet_status = 'Approved'
    elsif params[:status] == 'Reject'
      @app_pet.pet_status = 'Rejected'
    end
    @app_pet.save
    redirect_to "/admin/applications/#{@application.id}"
  end
end
