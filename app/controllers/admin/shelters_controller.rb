class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name
    @shelters_with_apps = Shelter.shelters_with_pending_applications
  end


end
