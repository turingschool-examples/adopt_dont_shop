class AdminSheltersController < ApplicationController

  def index
    # binding.pry
    @shelters = Shelter.reverse_alphabetical_order
  end
end