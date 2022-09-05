class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters
  end
end