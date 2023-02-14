class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetical_names
    @shelters_with_pending_applications = Shelter.pending_applications
  end
end