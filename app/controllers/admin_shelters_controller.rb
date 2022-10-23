class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetical
    @pending_shelters = Shelter.has_pending_apps
  end
end