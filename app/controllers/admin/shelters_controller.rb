class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetical_by_name
    @filtered_shelters = Shelter.filter_by_pets_with_pending_applications_alphabetically
  end

  def show
    @shelter = Shelter.find_by_sql("
      select shelters.id, shelters.name, shelters.city 
      from shelters 
      where shelters.id = #{params[:id]}")
  end
end