class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_name_reverse_alphabetical
    @shelter_names = Shelter.pending_applications
  end

end
