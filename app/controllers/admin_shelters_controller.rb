class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_alphabetically
    @pending_shelters = Shelter.with_pending_applications
  end
end
