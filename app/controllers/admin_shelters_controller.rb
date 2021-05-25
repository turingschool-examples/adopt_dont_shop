class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.names_sorted
    @applications_pending = Application.pending
  end

  def show
    @shelter = Shelter.find(params[:shelter_id])
  end
end
