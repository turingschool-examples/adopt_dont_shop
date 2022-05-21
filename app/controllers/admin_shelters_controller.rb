class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
  end
end
