class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_names
  end
end