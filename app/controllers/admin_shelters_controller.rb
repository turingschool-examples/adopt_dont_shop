class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_order_by_name
    @applications = Application.pending_apps
    @pending_shelters = Shelter.pending_names
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

end
