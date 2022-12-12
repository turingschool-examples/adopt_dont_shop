class AdminsController < ApplicationController

  def index
    @shelters = Shelter.order_by_alpha_desc
    @pending_app_shelters = Shelter.pending_app_shelters
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @approved ||= {}
    if params[:pet_id] != nil 
      @pet = Pet.find(params[:pet_id])
      set_approved(@pet.id, params[:approve])
    else
      @pet = nil
    end
  end

  private

  def set_approved(pet_id, status)
    @approved["#{pet_id}".to_sym] = status
  end
end
