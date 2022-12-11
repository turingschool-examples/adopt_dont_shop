class AdminSheltersController < ApplicationController 
 
  def index 
    @shelters = Shelter.reverse_alphabetical_order 
    @shelters_pending = Shelter.shelters_with_pending_applications
  end 
end 