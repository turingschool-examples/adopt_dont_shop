class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_desc
    # binding.pry
    @shelters_pending = Shelter.pending
  end

  
end