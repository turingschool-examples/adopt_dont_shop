class AdminController < ApplicationController
  def index
    @shelters = Shelter.order_by_alph
    @shelters_with_apps = Shelter.active_applications
  end

  def shelter_show
    @shelter = Shelter.find(params[:id])
  end

  def application_show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find_by(id: params[:id])
    @pet = Pet.find_by(id: params[:pet_id])
    @pet_application = ApplicationPet.find_by(pet_id: params[:pet_id], application_id: params[:id])
    @pet_applications = ApplicationPet.where(application_id: params[:id])
    @pet_application.update(pet_status: params[:pet_status])
    @pet.update(adoptable: params[:adoptable])
    if params[:pet_status] == "Rejected"
      @application.update(status: params[:pet_status])
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
