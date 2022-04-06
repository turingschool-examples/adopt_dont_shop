class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_order_by_name
    @applications = Application.pending_apps
    @pending_shelters = no_duplicate_pets
  end

  def show
    @shelter = Shelter.find(params[:id])
  end


  private
  def no_duplicate_pets
    shelters = Shelter.reverse_order_by_name
    applications = Application.pending_apps
    pending_shelters = []
    applications.each do |app|
      app.pets.each do |pet|
        pending_shelters << pet.shelter
      end
    end
    pending_shelters.uniq
  end
end
