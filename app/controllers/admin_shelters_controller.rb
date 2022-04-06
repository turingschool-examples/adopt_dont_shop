class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_alphabetically
    @pending_shelters = Shelter.with_pending_applications
  end

  def show
    @shelter = Shelter.find(params[:id])
    @full_address = Shelter.make_address_readable(@shelter.id)
  end
end
