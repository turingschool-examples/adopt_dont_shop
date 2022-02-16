class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  # def update
  #   @pets = PetApplication.where(pet_id: @pet.id, application_id: @application.id).update(adoption_status: "Approved")
  #
  #   @application = Application.find(params[:id])
  #   @pet = Pet.find(params[:pet_id])
  #   PetApplication.where(pet_id: @pet.id, application_id: @application.id).update(adoption_status: "Approved")
  #   redirect_to "/admin/applications/#{@application.id}"
  # end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_app = PetApplication.where(pet_id: @pet.id, application_id: @application.id).update(adoption_status: "Approved")
    redirect_to "/admin/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
