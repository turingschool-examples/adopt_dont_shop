class AdminSheltersController < ApplicationController 

  def index 
    @shelters = Shelter.all.rev_alpha
  end

end