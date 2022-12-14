class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application_pets = @application.order_app_pets_by_pets
    
    app_pets_status = @application.uniq_app_pets_status
    @already_adopted = "This pet has already been approved for adoption"
    
    if app_pets_status == ["Approved"]
        @application.update(app_status: "Approved")
    elsif !app_pets_status.include?("Pending")
      @application.update(app_status: "Rejected")
    end

    if params[:app_pet_id]
      @application_pet = ApplicationPet.find(params[:app_pet_id])
      if params[:pet_id]
        @application_pet.approve
        pet = Pet.find(params[:pet_id])
        pet.adopt
      elsif params[:reject_pet_id]
        @application_pet.reject
      end
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end