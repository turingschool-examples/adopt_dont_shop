class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_desc
    # binding.pry
  end
end