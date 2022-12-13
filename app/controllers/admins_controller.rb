class AdminsController < ApplicationController

  def index
    @shelters = Shelter.order_by_alpha_desc
    @pending_app_shelters = Shelter.pending_app_shelters
  end

  def show
    
    @application = Application.find(params[:id])
    @application.update!(status: "Approved") if approved
    @application.update!(status: "Rejected") if rejected
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

  def rejected
    check_approved.include?("false") && check_approved.include?(nil) == false
  end

end
