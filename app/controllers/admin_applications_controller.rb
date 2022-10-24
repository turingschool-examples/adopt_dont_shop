class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application_pet = ApplicationPet.find_by(pet_id: params[:pet_id], application_id: @application.id)

    if params[:approve] == "true"

      @approved = true
      @application_pet.update(:status => "Approved")
      # binding.pry
    elsif params[:approve] == "false"
      @application_pet.update(:status => "Rejected")
      @approved = false
    end
  end
end
