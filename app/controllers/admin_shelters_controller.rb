class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reverse
    @pending_shelters = Shelter.find_pending_apps
  end

end
