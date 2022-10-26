class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    # @application_pet = ApplicationPet.find_by(pet_id: params[:pet_id], application_id: @application.id)
    @application_pet = ApplicationPet.find_application_pet(params[:pet_id], @application.id)

    if params[:approve] == "true"
      @application_pet.update(:status => "Approved")
      # binding.pry
    elsif params[:approve] == "false"
      @application_pet.update(:status => "Rejected")
    end

    if @application.application_approved? == true
      @application.update(:status => "Approved")
      binding.pry
    end
  end
end
