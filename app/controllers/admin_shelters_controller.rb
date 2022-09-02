class AdminSheltersController < ApplicationController

  def show
    @shelter = Shelter.find(params[:id])
    @action_needed_pets = @shelter.action_needed_pets
  end

  def index
    @shelters = Shelter.order_by_reverse_alphabetical
  end
  
end