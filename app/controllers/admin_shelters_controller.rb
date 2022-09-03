class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reverse
  end
end
