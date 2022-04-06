class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_order_by_name
    @applications = Application.pending_apps
    # require "pry"; binding.pry
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end