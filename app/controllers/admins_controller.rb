class AdminsController < ApplicationController

  def index
    @shelters = Shelter.order_by_alpha_desc
    @pending_app_shelters = Shelter.pending_app_shelters
  end

  def show
    
    @application = Application.find(params[:id])
    @application.update!(status: "Approved") if approved
    
    @pets = @application.pets
    @pet_applications = @application.pet_applications
    

  end

  private

  def check_approved
    @application.pet_applications.pluck(:status)
  end

  def approved
    check_approved.all? { |status| status == "true" }
  end
end
