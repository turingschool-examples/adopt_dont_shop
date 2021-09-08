class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reversed
    @shelters_with_apps = Shelter.pending_applications
  end
end
