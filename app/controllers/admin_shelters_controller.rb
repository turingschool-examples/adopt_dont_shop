class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all
    @reversed = @shelters.reverse_alphabetical_order
    @pending = @shelters.pending_ordered
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
