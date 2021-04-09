class AdminController < ApplicationController
  def shelter
    @shelters = Shelter.order_by_name
  end
end
