class AdminSheltersController < ApplicationController 
  def index 
    @shelters = Shelter.order_by_name_desc 
    @shelters_with_pending_apps = Shelter.order_by_name_asc.shelters_with_pending_apps
  end

  def show
    @shelter = Shelter.find_shelter_raw(params[:shelter_id])
  end
end