class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_order
    @shelters_pending = Shelter.pending_apps.order(:name)
  end

  def show
    @shelter = Shelter.find_by_sql("SELECT id, name, address, city, zip FROM shelters WHERE id = #{params[:shelter_id]}")[0]
  end 
end