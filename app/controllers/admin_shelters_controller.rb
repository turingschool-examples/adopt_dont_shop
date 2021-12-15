class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_names
    @shelters_pending = Shelter.pending_applications
  end

  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet.update(pet_params)

  end

end
