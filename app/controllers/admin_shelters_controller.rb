class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT shelters.* FROM shelters ORDER BY name DESC")
    @pending_applications = Shelter.pending_applications
  end

  def show
    @shelter_info = Shelter.find_by_sql("SELECT shelters.name, shelters.city FROM shelters WHERE shelters.id = #{params[:shelter_id]}").first
  end
end