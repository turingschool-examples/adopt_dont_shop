class AdminSheltersController < ApplicationController
  def index
    @admin_shelters = Shelter.reverse_alphabetical_order
  end
end
