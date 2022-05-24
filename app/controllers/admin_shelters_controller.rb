class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.all.reverse_alpha_order
  end
end
