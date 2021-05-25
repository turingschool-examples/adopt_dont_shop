class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_alphabetical
    @shelters_w_pending_apps = Shelter.filter_by_pending_apps_ordered_alphabetically
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end