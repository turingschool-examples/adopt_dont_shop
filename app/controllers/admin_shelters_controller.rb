class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all
    @reversed = @shelters.reverse_alphabetical_order
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
