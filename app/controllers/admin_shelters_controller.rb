class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.find_by_sql('SELECT * FROM shelters ORDER BY name DESC')
    @pending_shelters = Shelter.pending
  end

  def show
    @shelter = Shelter.find(params[:id])
    @applications = @shelter.associated_applications
  end
end
