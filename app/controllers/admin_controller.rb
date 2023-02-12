class AdminController < ApplicationController

  def shelters
    @shelters = Shelter.order_by_name_reverse
  end
end