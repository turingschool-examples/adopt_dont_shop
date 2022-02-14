class AdminSheltersController < ApplicationController
  def index
    @admin_shelters = Shelter.order_reverse_alphaetical
  end
end
