class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical_names
  end
end
