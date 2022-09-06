class AdminsController < ApplicationController

  def index
    @shelters = Shelter.alphabetical_shelter
    @pending_shelters = Shelter.pending_apps
  end

  def show
    @application = Application.find(params[:id])

  end

  def update
    @application = Application.find(params[:id])
    if params[:app_status] == "Approved"
      pet_application = PetApplication.find_by(pet_id: params[:pet_id], application: @application)
      pet_application.update(approved?: true)
      render :show
    elsif params[:app_status] == "Rejected"
      pet_application = PetApplication.find_by(pet_id: params[:pet_id], application: @application)
      pet_application.update(rejected?: true)
      render :show
    end
  end
end
