class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_names
    @shelters_pending = Shelter.pending_applications
  end
end
