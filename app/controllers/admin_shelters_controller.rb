class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_desc
    @pending_shelters = Shelter.with_pending_applications
  end
end
