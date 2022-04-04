class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_reverse_alpha
    @pending = Shelter.pending
  end

end
