class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all.reverse_alfa
    @pending_shelter = Shelter.all.pending_status
  end
end 