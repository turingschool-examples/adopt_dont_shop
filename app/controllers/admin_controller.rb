class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters
    @pending = Shelter.pending_apps
  end
end