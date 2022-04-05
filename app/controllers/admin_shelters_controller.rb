class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_order_by_name
    @applications = Application.pending_apps
  end
end