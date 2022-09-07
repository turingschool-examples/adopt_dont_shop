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
    @pet_application.update(pet_status: "Approved")
    @pet.update(adoptable: false)
    redirect_to "/admin/applications/#{@application.id}"
  end
end
