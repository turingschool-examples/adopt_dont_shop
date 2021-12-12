class AdminSheltersController < ApplicationController
  def index
    
    @shelters = Shelter.all
    # organized_shelters = shelters.
  end
end
