class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical_names
    @pending_shelters = Shelter.pending_applications
  end
end
