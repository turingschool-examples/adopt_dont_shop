class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_alphabetically
    @pending_shelters = Shelter.with_pending_applications
  end

  def show
    @shelter = Shelter.find(params[:id])
    if Shelter.make_address_readable(@shelter.id)
      @address = Shelter.make_address_readable(@shelter.id)
    else
      @address = @shelter.city
    end
  end
end
