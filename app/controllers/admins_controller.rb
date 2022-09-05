class AdminsController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelter
    @pending_shelters = Shelter.pending_apps
  end
end
