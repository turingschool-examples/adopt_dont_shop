class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_order
    @shelters_pending = Shelter.pending_apps.order(:name)
  end

  def show
    @shelter = Shelter.shelter_show(params[:shelter_id])
  end 
end