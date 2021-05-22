class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_alphabetical
    @shelters_w_pending_apps = Shelter.filter_by_pending_apps
  end
end