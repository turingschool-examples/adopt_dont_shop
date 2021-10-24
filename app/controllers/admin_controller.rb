class AdminController < ApplicationController
  def shelters
    @shelters = Shelter.order_reverse_alphabetically
  end
end
