class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetical_names
  end
end