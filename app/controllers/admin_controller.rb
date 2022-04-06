class AdminController < ApplicationController
  def shelters
    @shelters = Shelter.reverse_alphabetical_order
  end
end