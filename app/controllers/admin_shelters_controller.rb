class AdminSheltersController < ApplicationController 
  def index 
    @shelters = Shelter.order_by_name_desc 
    @shelters_with_pending_apps = Shelter.shelters_with_pending_apps
  end
end