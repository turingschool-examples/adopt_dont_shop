class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_name
    @shelters_with_pending = Shelter.pending_applications
  end
end
