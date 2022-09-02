class AdminSheltersController < ApplicationController

  def show
    @shelter = Shelter.find(params[:id])
    @action_needed_pets = @shelter.action_needed_pets
  end
  
end