class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    @shelters_with_pending_applications = Shelter.pending
  end

  def show
    id = params[:id]
    @shelter = Shelter.find_by_sql("SELECT name, city FROM shelters WHERE shelters.id = #{id}")
  end
end