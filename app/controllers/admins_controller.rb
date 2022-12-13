class AdminsController < ApplicationController
  def index
    @shelters = Shelter.order_by_alpha_desc
    @pending_app_shelters = Shelter.pending_app_shelters
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_applications = @application.pet_applications
  end
end
